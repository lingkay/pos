<?php

namespace Gist\POSBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\TemplateBundle\Model\BaseController as Controller;
use Gist\POSBundle\Entity\POSTransaction;
use Gist\POSBundle\Entity\POSTransactionItem;
use Gist\POSBundle\Entity\POSTransactionPayment;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;

class POSController extends Controller
{
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        $params['indiv_options'] = array(
            'gift' => 'Gift/Free',
            'discamt' => 'Discount Amount',
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

        $params['card_class'] = array(
            'black' => 'Black',
            'silver' => 'Silver',
            'gold' => 'Gold'
        );

        $params['check_type_options'] = array(
            'cash_check' => 'Cash Check',
            'pdc' => 'PDC'
        );

        $params['gender_options'] = array(
            'male' => 'Male',
            'female' => 'Female'
        );

        $params['marital_options'] = array(
            'single' => 'Single',
            'married' => 'Married',
            'widow' => 'Widow'
        );

        $last_entry = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(array(),array('id' => 'DESC'),1);
        if (count($last_entry) > 0) {
            $params['next_id'] = '005-' . str_pad($last_entry->getID() + 1,6,'0',STR_PAD_LEFT);
            $params['next_sys_id'] = $last_entry->getID() + 1;
        } else {
            $params['next_id'] = '005-' . str_pad(0 + 1,6,'0',STR_PAD_LEFT);
            $params['next_sys_id'] = "1";
        }


        

        $url="http://erp.cilanthropist.co/inventory/pos/get/banks";
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url2="http://erp.cilanthropist.co/inventory/pos/get/terminal_operators";
        $result2 = file_get_contents($url2);
        $vars2 = json_decode($result2, true);

        $url_chg="http://erp.cilanthropist.co/pos_erp/get/charge_rates";
        $result_chg = file_get_contents($url_chg);
        $vars_chg = json_decode($result_chg, true);

        $opts = array();
        foreach ($vars_chg as $o)
            $opts[$o['id']] = $o['name']." @ ".$o['value']."%";


        $url3="http://erp.cilanthropist.co/inventory/pos/get/tax_coverage";
        $result3 = file_get_contents($url3);
        $vars3 = str_replace('"', '', $result3);

        $params['tax_coverage'] = $vars3;
        // $params['tax_coverage'] = "excl";

        $params['bank_options'] = $vars;
        $params['terminal_operators'] = $vars2;
        $params['charge_rates'] = $opts;

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    public function landingAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        

        return $this->render('GistPOSBundle:Dashboard:main.html.twig', $params);
    }


    // POS SAVING AND SENDING METHODS

    public function saveTransaction($trans_id, $trans_total, $transaction_balance, $status, $customer_id = null)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = new POSTransaction();

        $transaction->setStatus($status);

        $em->persist($transaction);
        $em->flush();
    }

    public function saveTransactionItems($trans_id, $prod_id, $prod_name, $orig_price, $min_price, $adjusted_price, $disc_type, $disc_value)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction_item = new POSTransactionItem();
        
        $transaction_item->setStatus($status);

        $em->persist($transaction_item);
        $em->flush();
    }

    public function saveTransactionPayments($trans_id, $payment_type, $amount)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction_payment = new POSTransactionPayment();
        
        $transaction_payment->setStatus($status);

        $em->persist($transaction_payment);
        $em->flush();
    }
}
