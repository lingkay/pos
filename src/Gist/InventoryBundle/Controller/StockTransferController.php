<?php

namespace Gist\InventoryBundle\Controller;

use Gist\TemplateBundle\Model\CrudController;
use Gist\InventoryBundle\Entity\StockTransfer;
use Gist\InventoryBundle\Entity\StockTransferEntry;
use Gist\CoreBundle\Template\Controller\TrackCreate;
use DateTime;

class StockTransferController extends CrudController
{
    use TrackCreate;
    public function __construct()
    {
        $this->route_prefix = 'gist_inv_stock_transfer';
        $this->title = 'Stock Transfer';

        $this->list_title = 'Stock Transfer';
        $this->list_type = 'dynamic';
        $this->repo = "GistInventoryBundle:StockTransfer";
    }

    public function indexAction()
    {
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $gl = $this->setupGridLoader();

        $params = $this->getViewParams('List', 'gist_inv_stock_transfer_index');

        $date_from = new DateTime();
        $date_to = new DateTime();
        $date_from->format("Y-m-d");
        $date_to->format("Y-m-d");

        $this->padFormParams($params, $date_from, $date_to);
        $twig_file = 'GistInventoryBundle:StockTransfer:index.html.twig';


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
            'GistInventoryBundle:StockTransfer:action.html.twig',
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
        return new StockTransfer();
    }

    protected function getGridJoins()
    {
        $grid = $this->get('gist_grid');
        return array(
            $grid->newJoin('d_inv','destination_inv_account','getDestination'),
            $grid->newJoin('s_inv','source_inv_account','getSource'),
        );
    }

    protected function getGridColumns()
    {
        $grid = $this->get('gist_grid');
        return array(
            $grid->newColumn('ID','getID','id'),
            $grid->newColumn('Status','getStatus','status'),
            $grid->newColumn('Date Create','getName','name','d_inv'),
            $grid->newColumn('Source','getName','name','s_inv'),
            $grid->newColumn('Destination','getName','name','d_inv'),
        );
    }

    public function editRollbackFormAction($id)
    {
        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');
        $this->checkAccess($this->route_prefix . '.view');
        $this->hookPreAction();

        $url= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/data_rollback/".$id."/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_ent= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/data_entries/".$id;
        $result_ent = file_get_contents($url_ent);
        $vars_ent = json_decode($result_ent, true);

        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Edit');
        $params['object'] = $vars[0];
        $params['entries'] = $vars_ent;
        $params['o_label'] = null;
        $params['readonly'] = true;
        $params['is_rolled_back'] = 'true';

        $this->padFormParams($params, $vars);

        return $this->render('GistTemplateBundle:Object:edit.html.twig', $params);
    }

    protected function padFormParams(&$params, $object = NULL)
    {
        header("Access-Control-Allow-Origin: *");
        $conf = $this->get('gist_configuration');
        $inv = $this->get('gist_inventory');

        $um = $this->get('gist_user');
        $params['user_opts'] = $um->getUserFullNameOptions();

        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');
        $url_from= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/from/".$pos_loc_id;
        $result_from = file_get_contents($url_from);
        $vars_from = json_decode($result_from, true);

        $url_to= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/to/".$pos_loc_id;
        $result_to = file_get_contents($url_to);
        $vars_to = json_decode($result_to, true);

        $url_opt= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/loc_options/".$pos_loc_id;
        $result_opt = file_get_contents($url_opt);
        $vars_opt = json_decode($result_opt, true);

        $url_cat= $conf->get('gist_sys_erp_url')."/inventory/damaged_items/get/prod_cats";
        $result_cat = file_get_contents($url_cat);
        $vars_cat = json_decode($result_cat, true);

        $params['cat_opts'] = $vars_cat;
        $params['sent'] = $vars_from;
        $params['receive'] = $vars_to;
        $params['wh_opts'] = $vars_opt;
        $params['item_opts'] = array('000'=>'-- Select Product --') + $inv->getProductOptionsTransfer();
        $params['pos_loc_id'] = $pos_loc_id;

        return $params;
    }

    /**
     * Send data to ERP for saving.
     * ERP Receiver: addPOSStockTransferAction
     * Tested: OK
     *
     * @return mixed
     */
    public function addSubmitAction()
    {
        $conf = $this->get('gist_configuration');
        $data = $this->getRequest()->request->all();
        try
        {
            $source_iacc = $pos_loc_id = $conf->get('gist_sys_pos_loc_id');;
            $destination_iacc = $data['destination'];

            $entries = [];
            foreach ($data['product_item_code'] as $index => $value) {
                $prod_item_code = $value;
                $qty = $data['quantity'][$index];

                $entries[] = array(
                    'code'=>$prod_item_code,
                    'quantity'=> $qty,
                );
            }

            $entries = http_build_query($entries);
            $url= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/add_new/".$source_iacc."/".$destination_iacc."/".$this->getUser()->getERPID()."/".$data['description']."/".$entries."/".$data['status']."/".$data['id'];

            $result = file_get_contents($url);
            $vars = json_decode($result, true);

            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Stock transfer failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }

            $this->addFlash('success', 'Stock transfer updated successfully.');
            if($this->submit_redirect){
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }else{
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

    /**
     * Send form data to ERP for updating
     * ERP Receiver: updatePOSStockTransferAction
     * Tested:
     *
     * @param $id
     * @return mixed
     */
    public function editSubmitAction($id)
    {
        $conf = $this->get('gist_configuration');
        $data = $this->getRequest()->request->all();

//        var_dump($data);
//        die();

        try
        {
            $uid = $this->getUser()->getERPID();
            if ($uid == '' || $uid == null) {
                $uid = 1;
            }

            $entries = [];
            foreach ($data['product_item_code'] as $index => $value) {
                $prod_item_code = $value;
                $qty = 0;
                if (isset($data['quantity'][$index])) {
                    $qty = $data['quantity'][$index];
                }

                $r_qty = 0;
                if (isset($data['received_quantity'][$index])) {
                    $r_qty = $data['received_quantity'][$index];
                }

                $p_qty = 0;
                if (isset($data['processed_quantity'][$index])) {
                    $p_qty = $data['processed_quantity'][$index];
                }

                $st_entry = 0;
                if (isset($data['st_entry'][$index])) {
                    $st_entry = $data['st_entry'][$index];
                }

                $entries[] = array(
                    'code'=>$prod_item_code,
                    'quantity'=> $qty,
                    'st_entry'=> $st_entry,
                    'received_quantity'=> $r_qty,
                    'processed_quantity'=> $p_qty,
                );
            }



            $entries = http_build_query($entries);

            if (isset($data['selected_user'])) {
                $uid = $data['selected_user'];
            }

            $url= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/update_status/".$id."/".$uid."/".$data['status']."/".$entries;
//            var_dump($url);
//            die();
            $result = file_get_contents($url);
            $vars = json_decode($result, true);

            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Stock transfer failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }


            $this->addFlash('success', 'Stock transfer updated successfully.');
            if($this->submit_redirect){
                return $this->redirect($this->generateUrl($this->getRouteGen()->getEdit(), array('id' => $id)).$this->url_append);
            }else{
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

    public function editRollbackSubmitAction($id)
    {
        $conf = $this->get('gist_configuration');
        $data = $this->getRequest()->request->all();

        try
        {
            $uid = $this->getUser()->getERPID();
            if ($uid == '' || $uid == null) {
                $uid = 1;
            }

            $entries = [];
            foreach ($data['product_item_code'] as $index => $value) {
                $prod_item_code = $value;
                $qty = $data['quantity'][$index];

                $r_qty = 0;
                if (isset($data['received_quantity'][$index])) {
                    $r_qty = $data['received_quantity'][$index];
                }

                $p_qty = 0;
                if (isset($data['processed_quantity'][$index])) {
                    $p_qty = $data['processed_quantity'][$index];
                }

                $entries[] = array(
                    'code'=>$prod_item_code,
                    'quantity'=> $qty,
                    'st_entry'=> $data['st_entry'][$index],
                    'received_quantity'=> $r_qty,
                    'processed_quantity'=> $p_qty,
                );
            }

            $entries = http_build_query($entries);


            if (isset($data['selected_user'])) {
                $uid = $data['selected_user'];
            }

            $url= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/pos/update_rollback/".$uid."/".$data['status']."/".$id;
            $result = file_get_contents($url);
            $vars = json_decode($result, true);

            if ($vars[0]['status'] == 'failed') {
                $this->addFlash('error', 'Stock transfer failed to update. Please refresh/reload form.');
                return $this->redirect($this->generateUrl($this->getRouteGen()->getList()));
            }


            $this->addFlash('success', 'Stock transfer updated successfully.');
            if($this->submit_redirect){
                return $this->redirect($this->generateUrl($this->getRouteGen()->getEdit(), array('id' => $id)).$this->url_append);
            }else{
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

    /**
     * Load form. Get data from ERP.
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

        $url= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/data/".$id."/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_ent= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/data_entries/".$id;
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

    /**
     * Print stock transfer form
     *
     * @param $id
     * @return mixed
     */
    public function printPDFAction($id)
    {
        $twig = "GistInventoryBundle:StockTransfer:print.html.twig";

        $conf = $this->get('gist_configuration');
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');

        $url= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/data/".$id."/".$pos_loc_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_ent= $conf->get('gist_sys_erp_url')."/inventory/stock_transfer/get/data_entries/".$id;
        $result_ent = file_get_contents($url_ent);
        $vars_ent = json_decode($result_ent, true);

        $params['emp'] = null;
        $params['dept'] = null;
        $params['all'] = $vars;
        $params['entries'] = $vars_ent;
        $pdf = $this->get('gist_pdf');
        $pdf->newPdf('A4');
        $html = $this->render($twig, $params);
        return $pdf->printPdf($html->getContent());
    }
}