<?php

namespace Gist\InventoryBundle\Controller;

use Gist\TemplateBundle\Model\CrudController;
//use Gist\InventoryBundle\Entity\DamagedItems;
use Gist\InventoryBundle\Entity\Product;
//use Gist\InventoryBundle\Entity\DamagedItemsEntry;
use Gist\CoreBundle\Template\Controller\TrackCreate;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;


class DamagedItemsController extends CrudController
{
    use TrackCreate;
    public function __construct()
    {
        $this->route_prefix = 'gist_inv_damaged_items';
        $this->title = 'Damaged Items';

        $this->list_title = 'Damaged Items';
        $this->list_type = 'dynamic';
        $this->repo = "GistInventoryBundle:Product";
    }

    public function indexAction()
    {
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $gl = $this->setupGridLoader();

        $params = $this->getViewParams('List', 'gist_inv_damaged_items_index');

        $date_from = new DateTime();
        $date_to = new DateTime();
        $date_from->format("Y-m-d");
        $date_to->format("Y-m-d");

        $this->padFormParams($params, $date_from, $date_to);
        $twig_file = 'GistInventoryBundle:DamagedItems:index.html.twig';


        $params['list_title'] = $this->list_title;
        $params['grid_cols'] = $gl->getColumns();
        return $this->render($twig_file, $params);
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

    protected function getGridJoins()
    {
        $grid = $this->get('gist_grid');
        return array(
        //            $grid->newJoin('d_inv','destination_inv_account','getDestination'),
            ////            $grid->newJoin('s_inv','source_inv_account','getSource'),
        );
    }


    protected function getGridColumns()
    {
        $grid = $this->get('gist_grid');
        return array(
            $grid->newColumn('ID','getID','id'),
        );
    }

    protected function padFormParams(&$params, $object = NULL)
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');

        $inv = $this->get('gist_inventory');
        //$params['wh_opts'] = array('-1'=>'-- Select Location --') + array('0'=>'Main Warehouse') + array('00'=>'Damaged Items Warehouse') + $inv->getPOSLocationOptions();
        //$params['item_opts'] = array('000'=>'-- Select Product --') + $inv->getProductOptionsTransfer();

        $url_from= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/from/".$pos_loc_id;
        $result_from = file_get_contents($url_from);
        $vars_from = json_decode($result_from, true);

        $url_to= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/to/".$pos_loc_id;
        $result_to = file_get_contents($url_to);
        $vars_to = json_decode($result_to, true);

        $url_opt= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/loc_options/".$pos_loc_id;
        $result_opt = file_get_contents($url_opt);
        $vars_opt = json_decode($result_opt, true);

        $params['sent'] = $vars_from;
        $params['receive'] = $vars_to;
        $params['wh_opts'] = $vars_opt;
        $params['item_opts'] = null;
        //$params['pos_loc_id'] = $pos_loc_id;

        //CATEGORY
//        $filter = array();
//        $categories = $em
//            ->getRepository('GistInventoryBundle:ProductCategory')
//            ->findBy(
//                $filter,
//                array('name' => 'ASC')
//            );
//
//        $cat_opts = array();
//        $cat_opts[''] = 'All';
//        foreach ($categories as $category)
//            $cat_opts[$category->getID()] = $category->getName();

        $url_cat= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/prod_cats";
        $result_cat = file_get_contents($url_cat);
        $vars_cat = json_decode($result_cat, true);

        $params['cat_opts'] = $vars_cat;

        $status_opts = array();
        $status_opts['requested'] = 'Requested';
        $status_opts['processed'] = 'Processed';
        $status_opts['delivered'] = 'Delivered';
        $status_opts['arrived'] = 'Arrived';

        $params['status_opts'] = $status_opts;

        return $params;
    }

    public function editFormAction($id)
    {
        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $em = $this->getDoctrine()->getManager();

        //get object from erp
        //$obj = $em->getRepository($this->repo)->find($id);
        $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/data/".$id."/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_ent= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/data_entries/".$id;
        $result_ent = file_get_contents($url_ent);
        $vars_ent = json_decode($result_ent, true);

//        var_dump($vars[0]['id']);
//        die();

        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Edit');
        $params['object'] = $vars[0];
        $params['entries'] = $vars_ent;
        $params['o_label'] = null;

        // check if we have access to form
        $params['readonly'] = true;

        $this->padFormParams($params, $vars);

        return $this->render('GistTemplateBundle:Object:edit.html.twig', $params);
    }

    protected function add($obj)
    {
        $em = $this->getDoctrine()->getManager();
        $data = $this->getRequest()->request->all();

        // validate
        $this->validate($data, 'add');

        // update db
        $this->update($obj, $data, true);

        $em->persist($obj);
        $em->flush();
        $this->hookPostSave($obj,true);

        // log
        $odata = $obj->toData();
        $this->logAdd($odata);
    }

    protected function update($o, $data, $is_new = false)
    {
        $em = $this->getDoctrine()->getManager();
        $inv = $this->get('gist_inventory');
        $config = $this->get('gist_configuration');

        if ($is_new) {

            $o->setDescription($data['description']);
            // initialize entries
            $entries = array();

            $em->persist($o);
            $em->flush();


            foreach ($data['product_item_code'] as $index => $value)
            {
                $prod_item_code = $value;
                $qty = $data['quantity'][$index];

                // product
                $prod = $em->getRepository('GistInventoryBundle:Product')->findOneBy(array('item_code'=>$prod_item_code));
                if ($prod == null)
                    throw new ValidationException('Could not find product.');

                //from src
                $entry = new DamagedItemsEntry();
                $entry->setDamagedItems($o)
                    ->setProduct($prod)
                    ->setQuantity($qty);


                $wh_src = $inv->findWarehouse($config->get('gist_main_warehouse'));

                echo $data['destination'][$index]."<br>";


                if ($data['destination'][$index] == 0) {
                    $wh_destination = $inv->findWarehouse($config->get('gist_main_warehouse'));
                } elseif ($data['destination'][$index] == '00') {
                    $wh_destination = $inv->findWarehouse($config->get('gist_damaged_items_warehouse'));
                } else {
                    $wh_destination = $em->getRepository('GistLocationBundle:POSLocations')->find($data['destination'][$index]);
                }


                $entry->setSource($wh_src->getInventoryAccount());
                $entry->setDestination($wh_destination->getInventoryAccount());

                $entry->setStatus('requested');
                $entry->setRequestingUser($this->getUser());

                $em->persist($entry);
                $em->flush();

                $entries[] = $entry;
            }

            //die();

            return $entries;
        } else {


        }
    }

    public function statusUpdateAction($id, $status)
    {
        $em = $this->getDoctrine()->getManager();
        $conf = $this->get('gist_configuration');
        //$data = $this->getRequest()->request->all();
        // override for AJAX to ERP
        try
        {
            //inventory/damaged_items/get/to
            // send data to ERP for updating.
            $uid = $this->getUser()->getERPID();
            if ($uid == '' || $uid == null) {
                $uid = 1;
            }
            $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/entry/status/".$id."/".$status."/".$uid;
            $result = file_get_contents($url);
            $vars = json_decode($result, true);

            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Damaged items form failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }

            $this->addFlash('success', 'Damaged items updated successfully.');
            if($this->submit_redirect){
                return $this->redirect($this->generateUrl($this->getRouteGen()->getEdit(), array('id' => $vars[0]['parentID'])).$this->url_append);
            }else{
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }
        }
        catch (ValidationException $e)
        {
            $this->addFlash('error', 'Database error occurred. Possible duplicate.');
            //return $this->addError($obj);
        }
        catch (DBALException $e)
        {
            $this->addFlash('error', 'Database error occurred. Possible duplicate.');
            error_log($e->getMessage());
            //return $this->addError($obj);
        }
    }

    //    FOR PROD SEARCH MODAL AJAX
    protected function setupGridLoaderAjax()
    {
        $data = $this->getRequest()->query->all();
        $grid = $this->get('gist_grid');

        // loader
        $gloader = $grid->newLoader();
        $gloader->processParams($data)
            ->setRepository($this->repo);

        // grid joins
        $gjoins = $this->getGridJoins();
        foreach ($gjoins as $gj)
            $gloader->addJoin($gj);

        // grid columns
        $gcols = $this->getGridColumnsAjax();

        // add action column if it's dynamic
        if ($this->list_type == 'dynamic')
            $gcols[] = $grid->newColumn('', 'getID', null, 'o', array($this, 'callbackGridAjax'), false, false);

        // add columns
        foreach ($gcols as $gc)
            $gloader->addColumn($gc);

        return $gloader;
    }

    protected function getGridColumnsAjax()
    {
        $grid = $this->get('gist_grid');
        return array(
            $grid->newColumn('Item Code', 'getItemCode', 'item_code','o', array($this,'formatItemCode')),
            $grid->newColumn('Barcode','getBarcode','barcode'),
            $grid->newColumn('Name', 'getName', 'name','o', array($this,'formatItemName')),
//            $grid->newColumn('Item Code', 'getItemCode', 'item_code','o', array($this,'formatDetails')),
        );
    }

    public function formatItemCode($val)
    {
        return '<input type="hidden" class="itemCode" value="'.$val.'">'.$val;
    }

    public function formatItemName($val)
    {
        return '<input type="hidden" class="itemName" value="'.$val.'">'.$val;
    }

    public function callbackGridAjax($id)
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
            'GistInventoryBundle:DamagedItems:action_search.html.twig',
            $params
        );
    }

    public function gridSearchProductAction($category = null)
    {
        $conf = $this->get('gist_configuration');

        $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/search_product/ajax2/".$category;

        if ($category == null) {
            $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/search_product/ajax2";
        }

        $result = file_get_contents($url);
        //$vars = json_decode($result, true);

        $resp = new Response($result);
        $resp->headers->set('Content-Type', 'application/json');
        return $resp;
    }

    protected function filterProductSearch($category = null)
    {
        $grid = $this->get('gist_grid');
        $fg = $grid->newFilterGroup();
        $date = new DateTime();


//        $grid->setRepository('GistInventoryBundle:Product');

        if($category != null and $category != 'null') {
            $qry[] = "(o.category = '".$category."')";
        }
        else {
            $qry[] = "(o.id > 0)";
        }

        if (!empty($qry))
        {
            $filter = implode(' AND ', $qry);
        }

        return $fg->where($filter);
    }
    //    END PROD SEARCH MODAL

    public function printPDFAction($id)
    {
        $settings = $this->get('hris_settings');
        $wf = $this->get('hris_workforce');
        $em = $this->getDoctrine()->getManager();
        $twig = "GistInventoryBundle:DamagedItems:print.html.twig";

        $conf = $this->get('gist_configuration');

        //getOutputData
        $data = $this->getOutputData($id);

        $params['emp'] = null;
        $params['dept'] = null;


        $params['all'] = $data;
        $pdf = $this->get('gist_pdf');
        $pdf->newPdf('A4');
        $html = $this->render($twig, $params);
        return $pdf->printPdf($html->getContent());
    }


    protected function hookPostSave($obj, $is_new = false)
    {

    }

    public function addSubmitAction()
    {
        header("Access-Control-Allow-Origin: *");
        $conf = $this->get('gist_configuration');
        $data = $this->getRequest()->request->all();
        // override for AJAX to ERP
        try
        {
            // send data to ERP for saving
            $source_iacc = $pos_loc_id = $conf->get('gist_sys_pos_loc_id');;
            $destination_iacc = $data['destination'];
//            $entries = http_build_query($data[])

            $entries = [];
            foreach ($data['product_item_code'] as $index => $value) {
                $prod_item_code = $value;
                $qty = $data['quantity'][$index];
                $dest = $data['destination'][$index];

                $entries[] = array(
                    'code'=>$prod_item_code,
                    'quantity'=> $qty,
                    'destination'=>$dest,
                );

            }

            $entries = http_build_query($entries);
            $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/add_new/".$source_iacc."/".$this->getUser()->getERPID()."/".$data['description']."/".$entries;
            $result = file_get_contents($url);
            $vars = json_decode($result, true);

            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Damaged items form failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } elseif ($vars[0]['status'] == 'success') {
                $this->addFlash('success', 'Damaged items form updated successfully.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } else {
                $this->addFlash('error', 'Damaged items form failed to save.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }
        }
        catch (ValidationException $e)
        {
            $this->addFlash('error', 'Database error occured. Possible duplicate.');
            //return $this->addError($obj);
        }
        catch (DBALException $e)
        {
            $this->addFlash('error', 'Database error occured. Possible duplicate.');
            error_log($e->getMessage());
            //return $this->addError($obj);
        }
    }
}
