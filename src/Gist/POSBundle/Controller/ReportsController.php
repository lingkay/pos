<?php

namespace Gist\POSBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\GridBundle\Model\Grid\Exception;
use Gist\TemplateBundle\Model\CrudController;
use Gist\POSBundle\Entity\POSTransaction;
use Gist\POSBundle\Entity\POSTransactionItem;
use Gist\POSBundle\Entity\POSTransactionSplit;
use Gist\POSBundle\Entity\POSClock;
use Gist\UserBundle\Entity\User;
use Gist\POSBundle\Entity\POSTransactionPayment;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;
use DateInterval;

class ReportsController extends CrudController     
{
    public function __construct()
    {
        $this->route_prefix = 'gist_pos_reports';
        $this->title = 'Reports';

        $this->list_title = 'Reports';
        $this->list_type = 'static';
    }

    protected function newBaseClass()
    {
        return new POSClock('');
    }

    protected function getObjectLabel($obj)
    {
        return $obj->getID();
    }

    protected function setupGridLoader()
    {
        $data = $this->getRequest()->query->all();
        $grid = $this->get('gist_grid');

        // loader
        $gloader = $grid->newLoader();
        $gloader->processParams($data)
            ->setRepository('GistPOSBundle:POSTransaction');

        // grid joins
        $gjoins = $this->getGridJoins();
        foreach ($gjoins as $gj)
            $gloader->addJoin($gj);

        // grid columns
        $gcols = $this->getGridColumns();

        $gcols[] = $grid->newColumn('', 'getID', null, 'o', array($this, 'callbackGridx'), false, false);

        // add columns
        foreach ($gcols as $gc)
            $gloader->addColumn($gc);

        return $gloader;
    }

    public function callbackGridx($id)
    {
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        $conf = $this->get('gist_configuration');
        $url=$conf->get('gist_sys_erp_url')."/inventory/pos/get/upsell_time";
        $result = file_get_contents($url);
        $upsell_seconds = str_replace('"', '', $result);


        $canUpsell = false;
        try {
            $date_orig = new DateTime();
            $date_orig = $date_orig->format('m/d/Y H:i:s');
            $date_end = $obj->getDateCreate()->add(new DateInterval('PT' . $upsell_seconds . 'S'))->format('m/d/Y H:i:s'); // adds 674165 secs
            if ($date_end > $date_orig) {
                $canUpsell = true;
            }
        } catch (Exception $e) {
            $canUpsell = false;
        }


        $params = array(
            'ea' => $obj->getExtraAmount(),
            'hasChild' => $obj->hasChild(),
            'hasSplit' => $obj->hasSplit(),
            'mode' => $obj->getTransactionMode(),
            'id' => $id,
            'canUpsell' => $canUpsell,
            'child_type' => $obj->getChildType(),
            'ea' => $obj->getExtraAmount(),
            'upsell_parent' => $obj->getID(),
            'transaction_display_id' => $obj->getTransDisplayId(),
            'route_edit' => $this->getRouteGen()->getEdit(),
            'route_delete' => $this->getRouteGen()->getDelete(),
            'prefix' => $this->route_prefix,
        );

        $this->padGridParams($params, $id);

        $engine = $this->get('templating');
        return $engine->render(
            'GistPOSBundle:Reports:action.html.twig',
            $params
        );
    }

    protected function getCustomerName($id)
    {
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id'=>$id));
        if (!$obj) {
            return 'N/A';
        }
        if ($obj) {
            return $obj->getLastName().', '.$obj->getFirstName().' '.$obj->getMiddleName();
        }
        return 'N/A';
    }

    protected function getCustomerCreator($id)
    {
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id'=>$id));
        if (!$obj) {
            return 'N/A';
        }
        $creator = $obj->getUserCreate();
        if ($creator) {
            return $creator->getDisplayName();
        }
        return 'N/A';
    }

    protected function getCustomer($id)
    {
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id'=>$id));
        if (!$obj) {
            return null;
        }

        return $obj;
    }

    public function editFormAction($id)
    {
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);

        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Edit');
        $params['object'] = $obj;
        $params['customer_name'] = $this->getCustomerName($obj->getCustomerId());
        $params['customer_creator'] = $this->getCustomerCreator($obj->getCustomerId());
        $params['customer'] = $this->getCustomer($obj->getCustomerId());
        $params['o_label'] = $this->getObjectLabel($obj);

        // check if we have access to form
        $params['readonly'] = !$this->getUser()->hasAccess($this->route_prefix . '.edit');

        $this->padFormParams($params, $obj);

        return $this->render('GistPOSBundle:Reports:edit_transaction.html.twig', $params);
    }

    public function splitFormAction($id)
    {
        $this->checkAccess($this->route_prefix . '.view');

        $this->hookPreAction();
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);

        $session = $this->getRequest()->getSession();
        $session->set('csrf_token', md5(uniqid()));

        $params = $this->getViewParams('Edit');
        $params['object'] = $obj;
        $params['customer_name'] = $this->getCustomerName($obj->getCustomerId());
        $params['customer_creator'] = $this->getCustomerCreator($obj->getCustomerId());
        $params['customer'] = $this->getCustomer($obj->getCustomerId());
        $params['o_label'] = $this->getObjectLabel($obj);

        $employee = $em->getRepository('GistUserBundle:User')->findAll();

        foreach ($employee as $emp)
        {
            $emp_opts[$emp->getErpId()] = $emp->getDisplayName();
        }
        $params['emp_opts'] = $emp_opts;

        // check if we have access to form
        $params['readonly'] = !$this->getUser()->hasAccess($this->route_prefix . '.edit');

        $this->padFormParams($params, $obj);

        return $this->render('GistPOSBundle:Reports:split_transaction.html.twig', $params);
    }

    public function splitFormSubmitAction($id)
    {
        $em = $this->getDoctrine()->getManager();
        $data = $this->getRequest()->request->all();
        $this->hookPreAction();
        try
        {
            $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(array('id'=>$id));

            //remove previous splits
            if ($transaction->hasSplit()) {
                foreach ($transaction->getSplits() as $split) {
                    $em->remove($split);
                }
                $em->flush();
            }

            foreach ($data['consultant_id'] as $key => $value) {
                $split_entry = new POSTransactionSplit();
                $consultant = $em->getRepository('GistUserBundle:User')->findOneBy(array('erp_id'=>$value));

                $split_entry->setConsultant($consultant);
                $split_entry->setTransaction($transaction);
                $split_entry->setAmount($data['amount_allocation'][$key]);
                $split_entry->setPercent($data['percent_allocation'][$key]);
                $em->persist($split_entry);
            }
            //die();
            $em->flush();
            $this->addFlash('success', 'Transaction split for '.$transaction->getTransDisplayId().' saved!');
            return $this->redirect($this->generateUrl('gist_pos_split_transaction_form',array('id'=>$id)).$this->url_append);

        }
        catch (ValidationException $e)
        {
            error_log($e->getMessage());
        }
        catch (DBALException $e)
        {
            error_log($e->getMessage());
        }

    }

    protected function getGridColumns()
    {
        $grid = $this->get('gist_grid');

        return array(
            $grid->newColumn('ID', 'getID', 'id'),
            $grid->newColumn('Receipt Number', 'getTransDisplayId', 'trans_display_id'),
            // $grid->newColumn('Reference', 'getReferenceTransactionDisplayID', 'id'),
            $grid->newColumn('Reference', 'getID', 'id','o',array($this,'formatReferenceLink')),
            $grid->newColumn('Transaction Date','getDateCreateFormattedPOS','date_create'),
            //$grid->newColumn('Location', 'null', 'null'),
            $grid->newColumn('EA', 'getExtraAmount', 'extra_amount'),
            $grid->newColumn('Type', 'getTransactionModeFormatted', 'mode'),
        );
    }

    public function formatReferenceLink($id)
    {
        $em = $this->getDoctrine()->getManager();
        $router = $this->get('router');
        $obj = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        if($obj->getReferenceTransaction() != null)
            return "<a style=\"text-decoration: none;\" href=\"".$router->generate('gist_pos_reports_edit_form', array('id' => $obj->getReferenceTransaction()->getID()))."\">".$obj->getReferenceTransactionDisplayID()."</a>";
        else 
            return "-";
    }

    public function formatReferenceLink2($id)
    {
        $em = $this->getDoctrine()->getManager();
        $router = $this->get('router');
        $obj = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        if($obj->getReferenceTransaction() != null)
            return $obj->getReferenceTransactionDisplayID();
        else
            return "-";
    }

    public function formatTransLink($id)
    {
        $em = $this->getDoctrine()->getManager();
        $router = $this->get('router');
        $obj = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        if ($obj)
            return "<a style=\"text-decoration: none;\" href=\"".$router->generate('gist_pos_index_refund', array('transaction_display_id' => $obj->getTransDisplayID()))."\">".$obj->getTransDisplayID()."</a>";
        else
            '-';
    }

    public function indexAction()
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
    	$this->title = 'Dashboard';
        $gl = $this->setupGridLoader();

        $params = $this->getViewParams('', 'gist_dashboard_index');
        $user_exist = $em->getRepository('GistUserBundle:User')->findAll();
        $params['sys_area_id'] = $conf->get('gist_sys_area_id');
        $params['users'] = $user_exist;
        $params['modes'] = array(
            'normal'=>'Normal',
            'quotation'=>'Quotation',
            'deposit'=>'Deposit',
            'upsell'=>'Upsell',
            'frozen'=>'Frozen'
        );
        $params['grid_cols'] = $gl->getColumns();

        //$params['sales_records'] = $em->getRepository('GistPOSBundle:POSTransaction')->findAll();


        return $this->render('GistPOSBundle:Reports:index.html.twig', $params);
    }

    public function indexRefundAction()
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $this->title = 'Dashboard';
        $gl = $this->setupRefundGridLoader();

        $params = $this->getViewParams('', 'gist_dashboard_index');
        $user_exist = $em->getRepository('GistUserBundle:User')->findAll();
        $params['sys_area_id'] = $conf->get('gist_sys_area_id');
        $params['users'] = $user_exist;
        $params['modes'] = array(
            'normal'=>'Normal',
            'quotation'=>'Quotation',
            'deposit'=>'Deposit',
            'upsell'=>'Upsell',
            'frozen'=>'Frozen'
        );
        $params['grid_cols'] = $gl->getColumns();

        //$params['sales_records'] = $em->getRepository('GistPOSBundle:POSTransaction')->findAll();


        return $this->render('GistPOSBundle:Reports:refund_index.html.twig', $params);
    }

    protected function setupRefundGridLoader()
    {
        $data = $this->getRequest()->query->all();
        $grid = $this->get('gist_grid');



        // loader
        $gloader = $grid->newLoader();
        $gloader->processParams($data)
            ->setRepository('GistPOSBundle:POSTransaction');

        // grid joins
        $gjoins = $this->getGridJoins();
        foreach ($gjoins as $gj)
            $gloader->addJoin($gj);

        // grid columns
        $gcols = $this->getRefundGridColumns();


        // add columns
        foreach ($gcols as $gc)
            $gloader->addColumn($gc);

        return $gloader;
    }

    public function gridRefundSalesHistoryAction($receipt_number = null, $date_from = null, $date_to = null, $mode = null)
    {
        $this->hookPreAction();

        $gloader = $this->setupRefundGridLoader();

        $gloader->setQBFilterGroup($this->filterRefundHistory($receipt_number,$date_from,$date_to, $mode));
        $gres = $gloader->load();
        $resp = new Response($gres->getJSON());
        $resp->headers->set('Content-Type', 'application/json');

        return $resp;
    }

    protected function getRefundGridColumns()
    {
        $grid = $this->get('gist_grid');

        return array(
            $grid->newColumn('ID', 'getID', 'id'),
            $grid->newColumn('Receipt Number', 'getID', 'id','o',array($this,'formatTransLink')),
            // $grid->newColumn('Reference', 'getReferenceTransactionDisplayID', 'id'),
            $grid->newColumn('Reference', 'getID', 'id','o',array($this,'formatReferenceLink2')),
            $grid->newColumn('Transaction Date','getDateCreateFormattedPOS','date_create'),
            //$grid->newColumn('Location', 'null', 'null'),
            $grid->newColumn('EA', 'getExtraAmount', 'extra_amount'),
            $grid->newColumn('Type', 'getTransactionModeFormatted', 'mode'),
        );
    }

    public function indexAutoSearchAction($mode)
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $this->title = 'Dashboard';
        $gl = $this->setupGridLoader();

        $params = $this->getViewParams('', 'gist_dashboard_index');
        $user_exist = $em->getRepository('GistUserBundle:User')->findAll();
        $params['sys_area_id'] = $conf->get('gist_sys_area_id');
        $params['users'] = $user_exist;
        $params['modes'] = array(
            'normal'=>'Normal',
            'quotation'=>'Quotation',
            'deposit'=>'Deposit',
            'upsell'=>'Upsell',
            'frozen'=>'Frozen'
        );
        $params['grid_cols'] = $gl->getColumns();
        $params['mode'] = $mode;

        //$params['sales_records'] = $em->getRepository('GistPOSBundle:POSTransaction')->findAll();


        return $this->render('GistPOSBundle:Reports:index.html.twig', $params);
    }

    public function landingAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        

        return $this->render('GistPOSBundle:Dashboard:main.html.twig', $params);
    }

    public function indexSubmitAction()
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $data = $this->getRequest()->request->all();
        $this->hookPreAction();
        try
        {
            
            $conf->set('gist_sys_area_id', $data['sys_area_id']);
            $em->flush(); 
            if($this->submit_redirect){
                return $this->redirect($this->generateUrl('gist_pos_settings'));
            }else{
                return $this->redirect($this->generateUrl($this->getRouteGen()->getEdit(),array('id'=>$obj->getID())).$this->url_append);
            }
        }
        catch (ValidationException $e)
        {
            error_log($e->getMessage());
            return $this->addError($obj);
        }
        catch (DBALException $e)
        {
            error_log($e->getMessage());
            return $this->addError($obj);
        }

    }



    public function gridSalesHistoryAction($receipt_number = null, $date_from = null, $date_to = null, $mode = null)
    {
        $this->hookPreAction();

        $gloader = $this->setupGridLoader();

        $gloader->setQBFilterGroup($this->filterSalesHistory($receipt_number,$date_from,$date_to, $mode));
        $gres = $gloader->load();
        $resp = new Response($gres->getJSON());
        $resp->headers->set('Content-Type', 'application/json');

        return $resp;
    }

    protected function filterSalesHistory($receipt_number = null, $date_from = null, $date_to = null, $mode = null)
    {
        $grid = $this->get('gist_grid');
        $fg = $grid->newFilterGroup();
        $date = new DateTime();

        $date_from = $date_from=='null'? new DateTime($date->format('Ym01')):new DateTime($date_from);
        $date_to = $date_to=='null'? new DateTime($date->format('Ymt')):new DateTime($date_to);
        $date_to = $date_to->modify('+1 day');

        $qry[] = "(o.date_create >= '".$date_from->format('Y-m-d')."' AND o.date_create < '".$date_to->format('Y-m-d')."')";

        
        if ($receipt_number != null and $receipt_number != 'null')
        {
            $qry[] = "(o.trans_display_id = '".$receipt_number."')";
        }

        if ($mode != null and $mode != 'null')
        {
            $qry[] = "(o.transaction_mode = '".$mode."')";
        }

        if (!empty($qry))
        {
            $filter = implode(' AND ', $qry);
        }

        return $fg->where($filter);
    }

    protected function filterRefundHistory($receipt_number = null, $date_from = null, $date_to = null, $mode = null)
    {
        $grid = $this->get('gist_grid');
        $fg = $grid->newFilterGroup();
        $date = new DateTime();

        $date_from = $date_from=='null'? new DateTime($date->format('Ym01')):new DateTime($date_from);
        $date_to = $date_to=='null'? new DateTime($date->format('Ymt')):new DateTime($date_to);
        $date_to = $date_to->modify('+1 day');

        $qry[] = "(o.date_create >= '".$date_from->format('Y-m-d')."' AND o.date_create < '".$date_to->format('Y-m-d')."')";

        $qry[] = "(o.transaction_mode = 'normal')";

        if ($receipt_number != null and $receipt_number != 'null')
        {
            $qry[] = "(o.trans_display_id = '".$receipt_number."')";
        }

        if ($mode != null and $mode != 'null')
        {
            $qry[] = "(o.transaction_mode = '".$mode."')";
        }

        if (!empty($qry))
        {
            $filter = implode(' AND ', $qry);
        }

        return $fg->where($filter);
    }

}
