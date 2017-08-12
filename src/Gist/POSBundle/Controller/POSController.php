<?php

namespace Gist\POSBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\TemplateBundle\Model\BaseController as Controller;

class POSController extends Controller
{
    public function indexAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        $params['indiv_options'] = array(
            'gift' => 'Gift/Free',
            'disc' => 'Discount %',
            'chg' => 'Change of Price'
        );

        $params['bulk_options'] = array(
            'none' => 'None',
            'bgift' => 'Gift',
            'bdiscamt' => 'Discount Amount',
            'bdisc' => 'Discount %',
            'bamt' => 'Amount to Pay'
        );

        $params['trans_options'] = array(
            'reg' => 'Regular Transaction',
            'per' => 'Per-item Discount',
            'bulk' => 'Bulk Discount'
        );

        $url="http://dev.gisterp2/inventory/pos/get/banks";
        $result = file_get_contents($url);
        $vars = json_decode($result, true);



        $params['bank_options'] = $vars;

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    public function landingAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        

        return $this->render('GistPOSBundle:Dashboard:main.html.twig', $params);
    }
}
