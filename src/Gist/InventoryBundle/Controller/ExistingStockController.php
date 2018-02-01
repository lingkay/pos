<?php

namespace Gist\InventoryBundle\Controller;

use Gist\TemplateBundle\Model\CrudController;
use Gist\InventoryBundle\Entity\Product;
use Gist\CoreBundle\Template\Controller\TrackCreate;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;


class ExistingStockController extends CrudController
{
    use TrackCreate;
    public function __construct()
    {
        $this->route_prefix = 'gist_inv_existing_stock';
        $this->title = 'Existing Stock';

        $this->list_title = 'Existing Stock';
        $this->list_type = 'dynamic';
        $this->repo = "GistInventoryBundle:Product";
    }

    public function indexAction($inv_type = null)
    {
        if ($inv_type == null) {
            $inv_type = 'sales';
        }

        $this->checkAccess($this->route_prefix . '.view');
        $conf = $this->get('gist_configuration');
        $this->hookPreAction();
        $pos_loc_id = $conf->get('gist_sys_pos_loc_id');

        $url= $conf->get('gist_sys_erp_url')."/inventory/existing_stock/pos/grid/".$pos_loc_id."/".$inv_type;
        $result = file_get_contents($url);
        $vars = json_decode($result, true);



        $params = $this->getViewParams('List', 'gist_inv_damaged_items_index');

        $date_from = new DateTime();
        $date_to = new DateTime();
        $date_from->format("Y-m-d");
        $date_to->format("Y-m-d");

        $this->padFormParams($params, $date_from, $date_to);
        $twig_file = 'GistInventoryBundle:ExistingStock:index.html.twig';



        $params['inv_type'] = $inv_type;
        $params['list_title'] = $this->list_title;
        $params['stocks'] = $vars;
        return $this->render($twig_file, $params);
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

        $inv_types = [];
        $inv_types += array('sales'=>'Sales');
        $inv_types += array('tester'=>'Tester');
        $inv_types += array('damaged'=>'Damaged');
        $inv_types += array('missing'=>'Missing');

        $params['inv_type_opts'] = $inv_types;

        return $params;
    }

}
