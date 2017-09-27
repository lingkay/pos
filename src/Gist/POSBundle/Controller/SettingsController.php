<?php

namespace Gist\POSBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\TemplateBundle\Model\CrudController;
use Gist\POSBundle\Entity\POSTransaction;
use Gist\POSBundle\Entity\POSTransactionItem;
use Gist\POSBundle\Entity\POSCustomer;
use Gist\POSBundle\Entity\POSClock;
use Gist\UserBundle\Entity\User;
use Gist\POSBundle\Entity\POSTransactionPayment;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;

class SettingsController extends CrudController     
{
    public function __construct()
    {
        $this->route_prefix = 'gist_pos_settings';
        $this->title = 'Settings';

        $this->list_title = 'Settings';
        $this->list_type = 'static';
    }

    protected function newBaseClass()
    {
        return new POSClock('');
    }

    protected function getObjectLabel($obj)
    {
        return $obj->getName();
    }

    public function indexAction()
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $user_exist = $em->getRepository('GistUserBundle:User')->findAll();
        $customers = $em->getRepository('GistPOSBundle:POSCustomer')->findAll();
        $params['sys_area_id'] = $conf->get('gist_sys_area_id');
        $params['sys_pos_url'] = $conf->get('gist_sys_pos_url');
        $params['sys_erp_url'] = $conf->get('gist_sys_erp_url');
        $params['users'] = $user_exist;
        $params['customers'] = $customers;

        return $this->render('GistPOSBundle:Settings:index.html.twig', $params);
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
            $conf->set('gist_sys_pos_url', $data['sys_pos_url']);
            $conf->set('gist_sys_erp_url', $data['sys_erp_url']);
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

    public function syncCustomersAction()
    {
        header("Access-Control-Allow-Origin: *");
        //$conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        //$area_id = $conf->get('gist_sys_area_id');

        $url="http://erp.purltech.com/customer/get/all";
        // $url="http://m55e.erp/pos_erp/get/users/".$area_id;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        foreach ($vars as $u) {
            //check if user already saved
            // echo $u['id']."<br>";

            $customer = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id' => $u['id']));
            $user = $em->getRepository('GistUserBundle:User')->findOneBy(array('erp_id' => $u['created_by']));
            if ($customer) {
                //user found. update record
                $customer->setFirstName($u['first_name']);
                $customer->setLastName($u['last_name']);
                $customer->setCEmailAddress($u['email']);
                $customer->setMobileNumber($u['mobile_number']);
                //$customer->setERPID($u['id']);
                $customer->setMiddleName($u['middle_name']);
                $customer->setGender($u['gender']);
                $customer->setMaritalStatus($u['marital_status']);
                $customer->setDateMarried($u['date_married']);
                $customer->setHomePhone($u['home_phone']);
                $customer->setBirthdate($u['birthdate']);
                $customer->setAddress1($u['address1']);
                $customer->setAddress2($u['address2']);
                $customer->setCity($u['city']);
                $customer->setState($u['state']);
                $customer->setCountry($u['country']);
                $customer->setZip($u['zip']);
                $customer->setNotes($u['notes']);
                $customer->setDisplayID($u['display_id']);
                if ($user != null) {
                    $customer->setUserCreate($user);
                }
                $em->persist($customer);

            } else {
                //user not found. create record
                $new_customer = new POSCustomer;
                $new_customer->setFirstName($u['first_name']);
                $new_customer->setLastName($u['last_name']);
                $new_customer->setCEmailAddress($u['email']);
                $new_customer->setMobileNumber($u['mobile_number']);
                $new_customer->setERPID($u['id']);
                $new_customer->setMiddleName($u['middle_name']);
                $new_customer->setGender($u['gender']);
                $new_customer->setMaritalStatus($u['marital_status']);
                $new_customer->setDateMarried($u['date_married']);
                $new_customer->setHomePhone($u['home_phone']);
                $new_customer->setBirthdate($u['birthdate']);
                $new_customer->setAddress1($u['address1']);
                $new_customer->setAddress2($u['address2']);
                $new_customer->setCity($u['city']);
                $new_customer->setState($u['state']);
                $new_customer->setCountry($u['country']);
                $new_customer->setZip($u['zip']);
                $new_customer->setNotes($u['notes']);
                $new_customer->setDisplayID($u['display_id']);
                if ($user != null) {
                    $new_customer->setUserCreate($user);
                }
                $em->persist($new_customer);

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
