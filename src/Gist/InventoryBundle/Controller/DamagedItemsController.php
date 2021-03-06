<?php

namespace Gist\InventoryBundle\Controller;

use Gist\TemplateBundle\Model\CrudController;
use Gist\InventoryBundle\Entity\Product;
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
        $conf = $this->get('gist_configuration');
        $this->hookPreAction();
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');

        $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/damaged_stocks/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_summ= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/pos/summary_table/".$pos_loc_id;
        $result_summ = file_get_contents($url_summ);
        $vars_summ = json_decode($result_summ, true);
//
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
        $params['summ'] = $vars_summ;
        $params['dmg_stocks'] = $vars;
        return $this->render($twig_file, $params);
    }

    public function gridSearchSummaryAction()
    {
        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');

        $url= $conf->get('gist_sys_erp_url')."/inventory/open_tester/pos/summary_table/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $resp = new Response($result);
        $resp->headers->set('Content-Type', 'application/json');

        return $resp;
    }

    /**
     *
     * This will show the form for user to add damaged products to damaged items container.
     * All submissions from this page will be displayed on the index/grid page.
     * NOTE: Will NOT SUM quantities of same product.
     *
     * @return mixed
     */
    public function addFormEntriesAction()
    {
        $this->checkAccess($this->route_prefix . '.add');

        $this->hookPreAction();
        $obj = $this->newBaseClass();


        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Add');
        $params['object'] = $obj;

        // check if we have access to form
        $params['readonly'] = !$this->getUser()->hasAccess($this->route_prefix . '.add');
        $this->padFormParams($params, $obj);

        return $this->render('GistInventoryBundle:DamagedItems:add_entries.form.html.twig', $params);
    }

    /**
     *
     * This will save new damaged items to damaged items container.
     * Initial status: damaged
     *
     * @return mixed
     */
    public function addSubmitEntriesAction()
    {
        $this->checkAccess($this->route_prefix . '.add');
        $conf = $this->get('gist_configuration');
        $this->hookPreAction();
        $data = $this->getRequest()->request->all();

        try
        {
            $source_loc_id = $conf->get('gist_sys_pos_loc_id');
            $entries = [];
            foreach ($data['product_item_code'] as $index => $value) {
                $prod_item_code = $value;
                $qty = $data['quantity'][$index];
                $remarks = $data['remarks'][$index];

                $entries[] = array(
                    'item_code'=>$prod_item_code,
                    'quantity'=> $qty,
                    'remarks'=>$remarks
                );
            }

            $entries = http_build_query($entries);

            $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/pos/add_entries2/".$source_loc_id."/".$this->getUser()->getERPID()."/".$entries."/posx";
            $result = file_get_contents($url, false);
            $vars = json_decode($result, true);


            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Damaged items form failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } elseif ($vars[0]['status'] == 'success') {
                $this->addFlash('success', 'Damaged items added successfully.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } else {
                $this->addFlash('error', 'Damaged items form failed to save.');
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

    /** FOR RECEIVE */
    public function viewFormReceiveAction($id)
    {
        $conf = $this->get('gist_configuration');
        $source_loc_id = $conf->get('gist_sys_pos_loc_id');
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/pos/get_receive_form_data/".$id."/".$source_loc_id;
        $result = file_get_contents($url, false);
        $vars = json_decode($result, true);

        $url_ent= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/pos/get_receive_form_data_entries/".$id."/".$source_loc_id;
        $result_ent = file_get_contents($url_ent, false);
        $vars_ent = json_decode($result_ent, true);

        $params = $this->getViewParams('Edit');
        $params['object'] = $vars[0];
        $params['entries'] = $vars_ent;
        $params['o_label'] = null;
        $params['readonly'] = true;

        $this->padFormParams($params, $vars);

        return $this->render('GistInventoryBundle:DamagedItems:receive_form.html.twig', $params);
    }

    public function submitFormReceiveAction($id)
    {
        $conf = $this->get('gist_configuration');
        $source_loc_id = $conf->get('gist_sys_pos_loc_id');
        //$dmgManager = $this->get('gist_inventory_damaged_items_managed');
        $this->checkAccess($this->route_prefix . '.edit');
        $this->hookPreAction();

        try
        {
            $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/pos/receive_items/".$source_loc_id."/".$this->getUser()->getERPID()."/".$id;
            $result = file_get_contents($url, false);
            $vars = json_decode($result, true);


            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Damaged items form failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } elseif ($vars[0]['status'] == 'success') {
                $this->addFlash('success', 'Damaged items returned successfully.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } else {
                $this->addFlash('error', 'Damaged items form failed to save.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }
        }
        catch (ValidationException $e)
        {
            $this->addFlash('error', 'Database error occurred. Possible duplicate.'.$e);
            return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
        }
        catch (DBALException $e)
        {
            $this->addFlash('error', 'Database error occurred. Possible duplicate.'.$e);
            error_log($e->getMessage());
            return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
        }
    }

    /** FOR RETURN */
    public function addFormReturnAction($ids)
    {
        $this->checkAccess($this->route_prefix . '.add');
        $em = $this->getDoctrine()->getManager();
        $inv = $this->get('gist_inventory');
        $config = $this->get('gist_configuration');


        $this->hookPreAction();
        $obj = $this->newBaseClass();

        if (strpos($ids, ',') !== false) {
            $product_ids = explode(',', $ids);
        } else {
            $product_ids = array($ids);
        }

        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Add');
        $params['object'] = $obj;

        // check if we have access to form
        $params['readonly'] = !$this->getUser()->hasAccess($this->route_prefix . '.add');
        $this->padFormParams($params, $obj);

        $url= $config->get('gist_sys_erp_url')."/inventory/damaged_items/pos/get_selected_for_return/".$ids."/posx";
        $result = file_get_contents($url);
        $vars = json_decode($result, true);


        $params['selected_products'] = $vars;

        return $this->render('GistTemplateBundle:Object:add.html.twig', $params);
    }

    public function addReturnSubmitAction($ids)
    {
        $config = $this->get('gist_configuration');
        $this->checkAccess($this->route_prefix . '.add');
        $data = $this->getRequest()->request->all();

        $this->hookPreAction();
        try
        {
            $source_loc_id = $config->get('gist_sys_pos_loc_id');
            $destination_id = $data['destination'];
            $description = $data['description'];
            $entries = [];
            foreach ($data['prod_item_code'] as $index => $value) {
                $entry_id = $data['entry_id'][$index];
                $entries[] = array(
                    'entry_id'=>$entry_id,
                );
            }

            $entries = http_build_query($entries);
            $url= $config->get('gist_sys_erp_url')."/inventory/damaged_items/pos/save_for_return/".$description."/".$this->getUser()->getERPID()."/".$source_loc_id."/".$destination_id."/".$entries;
            $result = file_get_contents($url);
            $vars = json_decode($result, true);

            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Damaged items form failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } elseif ($vars[0]['status'] == 'success') {
                $this->addFlash('success', 'Damaged items set for return successfully.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            } else {
                $this->addFlash('error', 'Damaged items form failed to save.');
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
    /** END FOR RETURN */

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

        $url_from= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/from/".$pos_loc_id;
        $result_from = file_get_contents($url_from);
        $vars_from = json_decode($result_from, true);

        $url_to= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/to/".$pos_loc_id;
        $result_to = file_get_contents($url_to);
        $vars_to = json_decode($result_to, true);

        $url_opt= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/loc_options/".$pos_loc_id;
        $result_opt = file_get_contents($url_opt);
        $vars_opt = json_decode($result_opt, true);

        $url_cat= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/prod_cats";
        $result_cat = file_get_contents($url_cat);
        $vars_cat = json_decode($result_cat, true);

        $url_reasons= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/reasons";
        $result_reasons = file_get_contents($url_reasons);
        $vars_reasons = json_decode($result_reasons, true);

        $params['sent'] = $vars_from;
        $params['receive'] = $vars_to;
        $params['wh_opts'] = $vars_opt;
        $params['item_opts'] = null;
        $params['cat_opts'] = $vars_cat;
        $params['reason_opts'] = $vars_reasons;

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

    protected function add($obj)
    {
        $em = $this->getDoctrine()->getManager();
        $data = $this->getRequest()->request->all();

        $this->validate($data, 'add');
        $this->update($obj, $data, true);

        $em->persist($obj);
        $em->flush();
        $this->hookPostSave($obj,true);

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
            $entries = array();

            $em->persist($o);
            $em->flush();

            foreach ($data['product_item_code'] as $index => $value)
            {
                $prod_item_code = $value;
                $qty = $data['quantity'][$index];

                $prod = $em->getRepository('GistInventoryBundle:Product')->findOneBy(array('item_code'=>$prod_item_code));
                if ($prod == null)
                    throw new ValidationException('Could not find product.');

                $entry = new DamagedItemsEntry();
                $entry->setDamagedItems($o)
                    ->setProduct($prod)
                    ->setQuantity($qty);

                $wh_src = $inv->findWarehouse($config->get('gist_main_warehouse'));

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

            return $entries;

        }
    }

    /**
     * Send update to ERP
     *
     * @param $id
     * @param $status
     * @return mixed
     */
    public function statusUpdateAction($id, $status)
    {
        $conf = $this->get('gist_configuration');

        try
        {
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
        }
        catch (DBALException $e)
        {
            $this->addFlash('error', 'Database error occurred. Possible duplicate.');
            error_log($e->getMessage());
        }
    }

    protected function setupGridLoaderAjax()
    {
        $data = $this->getRequest()->query->all();
        $grid = $this->get('gist_grid');

        $gloader = $grid->newLoader();
        $gloader->processParams($data)
            ->setRepository($this->repo);

        $gjoins = $this->getGridJoins();
        foreach ($gjoins as $gj)
            $gloader->addJoin($gj);

        $gcols = $this->getGridColumnsAjax();

        if ($this->list_type == 'dynamic')
            $gcols[] = $grid->newColumn('', 'getID', null, 'o', array($this, 'callbackGridAjax'), false, false);

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

    /**
     * @param $id
     * @return mixed
     */
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

    /**
     * Update product search modal entries
     *
     * @param null $category
     * @return Response
     */
    public function gridSearchProductAction($category = null)
    {
        $conf = $this->get('gist_configuration');

        $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/search_product/ajax2/".$category;

        if ($category == null) {
            $url= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/search_product/ajax2";
        }

        $result = file_get_contents($url);
        $resp = new Response($result);
        $resp->headers->set('Content-Type', 'application/json');
        return $resp;
    }

    /**
     * @param null $category
     * @return mixed
     */
    protected function filterProductSearch($category = null)
    {
        $grid = $this->get('gist_grid');
        $fg = $grid->newFilterGroup();

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

    /**
     * Print damaged items form
     *
     * @param $id
     * @return mixed
     */
    public function printPDFAction($id)
    {
        $twig = "GistInventoryBundle:DamagedItems:print.html.twig";

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

    /**
     * Send form data to ERP for saving
     *
     * @return mixed
     */
    public function addSubmitAction()
    {
        header("Access-Control-Allow-Origin: *");
        $conf = $this->get('gist_configuration');
        $data = $this->getRequest()->request->all();
        try
        {
            $source_iacc = $pos_loc_id = $conf->get('gist_sys_pos_loc_id');;
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
        }
        catch (DBALException $e)
        {
            $this->addFlash('error', 'Database error occured. Possible duplicate.');
            error_log($e->getMessage());
        }
    }
}
