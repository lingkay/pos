<?php

namespace Gist\POSBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\TemplateBundle\Model\CrudController;
use Gist\POSBundle\Entity\POSTransaction;
use Gist\POSBundle\Entity\POSTransactionItem;
use Gist\POSBundle\Entity\POSClock;
use Gist\UserBundle\Entity\User;
use Gist\POSBundle\Entity\POSTransactionPayment;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;

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
        $params = array(
            'mode' => $obj->getTransactionMode(),
            'id' => $id,
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
        $params['o_label'] = $this->getObjectLabel($obj);

        // check if we have access to form
        $params['readonly'] = !$this->getUser()->hasAccess($this->route_prefix . '.edit');

        $this->padFormParams($params, $obj);

        return $this->render('GistPOSBundle:Reports:edit_transaction.html.twig', $params);
    }

    protected function getGridColumns()
    {
        $grid = $this->get('gist_grid');

        return array(
            $grid->newColumn('ID', 'getID', 'id'),
            $grid->newColumn('Receipt Number', 'getTransDisplayId', 'trans_display_id'),
            $grid->newColumn('Location', 'getID', 'id'),
            $grid->newColumn('EA', 'getExtraAmount', 'extra_amount'),
            $grid->newColumn('Type', 'getTransactionModeFormatted', 'mode'),
        );
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
        $params['grid_cols'] = $gl->getColumns();
        // $url3="http://erp.purltech.com/inventory/pos/get/tax_coverage";
        // $result3 = file_get_contents($url3);
        // $vars3 = str_replace('"', '', $result3);
        $params['sales_records'] = $em->getRepository('GistPOSBundle:POSTransaction')->findAll();
        // $params['test'] = $test;
        // $params['tax_coverage'] = $vars3;
        // // $params['tax_coverage'] = "excl";

        // $params['cust_required_fields'] = $vars_req;
        // $params['bank_options'] = $vars;
        // $params['terminal_operators'] = $vars2;
        // $params['charge_rates'] = $opts;

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

    public function syncUsersAction()
    {
        header("Access-Control-Allow-Origin: *");
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $area_id = $conf->get('gist_sys_area_id');

        $url="http://erp.purltech.com/pos_erp/get/users/".$area_id;
        // $url="http://m55e.erp/pos_erp/get/users/".$area_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        foreach ($vars as $u) {
            //check if user already saved
            // echo $u['id']."<br>";

            $user_exist = $em->getRepository('GistUserBundle:User')->findOneBy(array('erp_id' => $u['id']));
            if ($user_exist) {
                //user found. update record
                //$user_exist->setID($u['id']); 
                $user_exist->setUsername($u['username']); 
                //$user_exist->setUsernameCanonical($u['username_canonical']); 
                $user_exist->setSalt($u['salt']); 
                $user_exist->setEmail($u['email']); 
                $user_exist->setPassword($u['password']); 
                //$user_exist->setPlainPassword($u['plainPassword']); 
                //$user_exist->setConfirmationToken($u['confirmationToken']); 
                $user_exist->setEnabled($u['enabled']); 
                $user_exist->setFirstName($u['first_name']); 
                $user_exist->setMiddleName($u['middle_name']); 
                $user_exist->setLastName($u['last_name']); 
                $user_exist->setBrand($u['brand']); 
                $user_exist->setDepartment($u['department']); 
                $user_exist->setPosition($u['position']); 
                $user_exist->setCommissionType($u['commission_type']); 
                $user_exist->setContactNumber($u['contact_number']);
                $em->persist($user_exist);

            } else {
                //user not found. create record
                $user_new = new User;
                $user_new->setERPID($u['id']); 
                $user_new->setUsername($u['username']); 
                //$user_new->setUsernameCanonical($u['username_canonical']); 
                $user_new->setSalt($u['salt']); 
                $user_new->setEmail($u['email']); 
                $user_new->setPassword($u['password']); 
                //$user_new->setPlainPassword($u['plainPassword']); 
                //$user_new->setConfirmationToken($u['confirmationToken']); 
                $user_new->setEnabled($u['enabled']); 
                $user_new->setFirstName($u['first_name']); 
                $user_new->setMiddleName($u['middle_name']); 
                $user_new->setLastName($u['last_name']); 
                $user_new->setBrand($u['brand']); 
                $user_new->setDepartment($u['department']); 
                $user_new->setPosition($u['position']); 
                $user_new->setCommissionType($u['commission_type']); 
                $user_new->setContactNumber($u['contact_number']);
                $em->persist($user_new);

            }
        }

        // die();`
        try
        {
            $em->flush();
        }
        catch (UniqueConstraintViolationException $e) {
            var_dump($e->getMessage());
            die();
        }
        catch (ValidationException $e)
        {
            var_dump($e->getMessage());
            die();
        }
        catch (DBALException $e)
        {
            var_dump($e->getMessage());
            die();
        }
        

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }

}
