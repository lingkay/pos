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

        

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }
}
