<?php

namespace Hris\DashboardBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\TemplateBundle\Model\BaseController as Controller;

class DashboardController extends Controller
{
    public function indexAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'hris_dashboard_index');

        

        return $this->render('HrisDashboardBundle:Dashboard:index.html.twig', $params);
    }
}
