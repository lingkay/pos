<?php

namespace Gist\InventoryBundle\Controller;

use Gist\TemplateBundle\Model\CrudController;
use Gist\InventoryBundle\Entity\Product;
use Gist\CoreBundle\Template\Controller\TrackCreate;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;


class CountingController extends CrudController
{
    use TrackCreate;

    public function __construct()
    {
        $this->route_prefix = 'gist_inv_counting';
        $this->title = 'Stock Counting';

        $this->list_title = 'Stock Counting';
        $this->list_type = 'dynamic';
        $this->repo = "GistInventoryBundle:Product";
    }

    public function indexAction()
    {
        $this->checkAccess($this->route_prefix . '.view');
        $conf = $this->get('gist_configuration');
        $this->hookPreAction();
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');
        $gl = $this->setupGridLoader();

        $params = $this->getViewParams('List', 'gist_inv_counting_index');

        $url = $conf->get('gist_sys_erp_url') . "/inventory/counting_form/pos/is_form_valid/" . $pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $params['form_disabled'] = $vars[0][0]; //change to dynamic
        $params['detected_submission_timeslot'] = $vars[0][1]; //change to dynamic

        $url_fields = $conf->get('gist_sys_erp_url') . "/inventory/counting_form/pos/form_fields/" . $pos_loc_id;
        $result_fields = file_get_contents($url_fields);
        $vars_fields = json_decode($result_fields, true);

        $params['sysCountVisibility'] = $vars_fields[0]['sys_stock_visibility'];
        $params['counting_rule'] = $vars_fields[0]['counting_rule'];

        $params['form_fields'] = $vars_fields;

        $url_subs = $conf->get('gist_sys_erp_url') . "/inventory/counting/pos/grid_data/" . $pos_loc_id;
        $result_subs = file_get_contents($url_subs);
        $vars_subs = json_decode($result_subs, true);

        $params['submissions'] = $vars_subs;

        $date_from = new DateTime();
        $date_to = new DateTime();
        $date_from->format("Y-m-d");
        $date_to->format("Y-m-d");

        $this->padFormParams($params, $date_from, $date_to);
        $twig_file = 'GistInventoryBundle:Counting:index.html.twig';


        $params['list_title'] = $this->list_title;
        $params['grid_cols'] = $gl->getColumns();
        return $this->render($twig_file, $params);
    }

    public function indexSubmitAction()
    {
        $em = $this->getDoctrine()->getManager();
        $config = $this->get('gist_configuration');
        $inv = $this->get('gist_inventory');
        $data = $this->getRequest()->request->all();
        $conf = $this->get('gist_configuration');
        $this->hookPreAction();
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');


        try
        {
            $source_loc_id = $conf->get('gist_sys_pos_loc_id');
            $entries = [];
            foreach ($data['product_id'] as $index => $value) {
                $product_id = $value;
                $count = $data['currentCount'][$index];
                $current = $data['existingCount'][$index];

                if ($count != '') {
                    $entries[] = array(
                        'product_id'=>$product_id,
                        'count'=> $count,
                        'current'=>$current
                    );
                }
            }

            if (count($entries) <= 0) {
                $this->addFlash('error', 'No count(s) to process!');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }

            $entries = http_build_query($entries);

            $url= $conf->get('gist_sys_erp_url')."/inventory/counting_form/pos/submit/".$source_loc_id."/".$this->getUser()->getERPID()."/".$entries;
            $result = file_get_contents($url, false);
            $vars = json_decode($result, true);


            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Counting form submission failed.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } elseif ($vars[0]['status'] == 'success') {
                $this->addFlash('success', 'Counting form submitted successfully.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } else {
                $this->addFlash('error', 'Counting form submission failed.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }
        }
        catch (ValidationException $e)
        {
            $this->addFlash('error', 'Database error occured. Possible duplicate.'.$e);
            //return $this->addError($obj);
        }
        catch (DBALException $e)
        {
            $this->addFlash('error', 'Database error occured. Possible duplicate.'.$e);
            error_log($e->getMessage());
            //return $this->addError($obj);
        }
    }

    public function callbackGrid($id)
    {
        $params = array(
            'id' => $id,
            'route_edit' => $this->getRouteGen()->getEdit(),
            'route_delete' => $this->getRouteGen()->getDelete(),
            'prefix' => $this->route_prefix,
        );

        $this->padGridParams($params, $id);
        $engine = $this->get('templating');
        return $engine->render(
            'GistInventoryBundle:DamagedItems:action.html.twig',
            $params
        );

    }

    protected function getGridJoins()
    {
        $grid = $this->get('gist_grid');
        return array(
        );
    }

    protected function getGridColumns()
    {
        $grid = $this->get('gist_grid');
        return array(
            $grid->newColumn('ID','getID','id'),
        );
    }

    protected function getObjectLabel($obj)
    {
        if ($obj == null)
        {
            return '';
        }
        return $obj->getID();
    }

    protected function newBaseClass()
    {
        return new Product();
    }

    /**
     * @param $params
     * @param null $object
     * @return mixed
     */
    protected function padFormParams(&$params, $object = NULL)
    {
        header("Access-Control-Allow-Origin: *");
        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');


        return $params;
    }

    /**
     * Load form. Get data from ERP
     *
     * @param $id
     * @return mixed
     */
    public function editFormAction($id)
    {
        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $em = $this->getDoctrine()->getManager();

        $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/data/".$id."/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_ent= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/data_entries/".$id;
        $result_ent = file_get_contents($url_ent);
        $vars_ent = json_decode($result_ent, true);

        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Edit');
        $params['object'] = $vars[0];
        $params['entries'] = $vars_ent;
        $params['o_label'] = null;

        $params['readonly'] = true;

        $this->padFormParams($params, $vars);

        return $this->render('GistTemplateBundle:Object:edit.html.twig', $params);
    }
}
