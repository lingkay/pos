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

    public function getFrozenTransactionsAction()
    {
        $em = $this->getDoctrine()->getManager();
        $frozen_transactions = $em->getRepository('GistPOSBundle:POSTransaction')->findBy(array('status'=>'Frozen'));

        $transactions = array();

        foreach ($frozen_transactions as $ft) {
            $transactions[] = array('id'=>$ft->getID(), 'disp_id'=>$ft->getTransDisplayId(),'date_created'=>$ft->getDateCreateFormatted3());
        }

        return new JsonResponse($transactions);
    }


    // POS SAVING AND SENDING METHODS

    // /pos/save_transaction/{id}/{display_id}/{total}/{balance}/{type}/{customer_id}/{status}
    public function saveTransactionAction($id, $display_id, $total, $balance, $type, $customer_id, $status)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = new POSTransaction();

        $transaction->setId($id);
        $transaction->setTransDisplayId($display_id);
        $transaction->setCustomerId($customer_id);
        $transaction->setTransactionBalance($balance);
        $transaction->setTransactionTotal($total);
        $transaction->setTransactionType($type);
        $transaction->setStatus('Frozen');
        $transaction->setSyncedToErp('false');


        $em->persist($transaction);
        $em->flush();

        $list_opts[] = array('status'=>$transaction->getStatus(),'new_id'=>$transaction->getID());
        return new JsonResponse($list_opts);
    }

    public function saveTransactionItemsAction($trans_sys_id, $prod_id, $prod_name, $orig_price, $min_price, $adjusted_price, $discount_type, $discount_value)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction_item = new POSTransactionItem();

        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($trans_sys_id);

        if (trim($adjusted_price) == '' || $adjusted_price == null) {
            $adjusted_price = '0';
        }

        if (trim($discount_type) == '' || $discount_type == null) {
            $discount_type = 'none';
        }

        if (trim($discount_value) == '' || $discount_value == null) {
            $discount_value = '0';
        }


        
        $transaction_item->setTransaction($transaction);
        $transaction_item->setProductId($prod_id);
        $transaction_item->setOrigPrice($orig_price);
        $transaction_item->setMinimumPrice($min_price);
        $transaction_item->setAdjustedPrice($adjusted_price);
        $transaction_item->setName($prod_name);
        $transaction_item->setDiscountType($discount_type);
        $transaction_item->setDiscountValue($discount_value);

        $em->persist($transaction_item);
        $em->flush();

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }

    public function saveTransactionPaymentsAction($trans_sys_id, $payment_type, $amount)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction_payment = new POSTransactionPayment();

        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($trans_sys_id);
        
        $transaction_payment->setTransaction($transaction);
        $transaction_payment->setType($payment_type);
        $transaction_payment->setAmount($amount);

        $em->persist($transaction_payment);
        $em->flush();

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }


    // SYNC TO ERP POS DATA
    public function syncDataAction()
    {
        $em = $this->getDoctrine()->getManager();

        //send transactions
        $transactions = $em->getRepository('GistPOSBundle:POSTransaction')->findBy(array('synced_to_erp'=>'false'));
        
        //send items (loop transactions then loop items)
        //send payments (loop transactions then loop payments)
        foreach ($transactions as $transaction) {
            file_get_contents("http://dev.gisterp2/pos_erp/save_transaction/".$transaction->getID()."/".$transaction->getTransDisplayId()."/".$transaction->getTransactionTotal()."/".$transaction->getTransactionBalance()."/".$transaction->getTransactionType()."/".$transaction->getCustomerId()."/".$transaction->getStatus());

            $transaction->setSyncedToErp('true');
            $em->persist($transaction);

            $payments = $em->getRepository('GistPOSBundle:POSTransactionPayment')->findBy(array('transaction'=>$transaction));
            $items = $em->getRepository('GistPOSBundle:POSTransactionItem')->findBy(array('transaction'=>$transaction));

            foreach ($payments as $payment) {
                // {trans_sys_id}/{payment_type}/{amount}
                file_get_contents("http://dev.gisterp2/pos_erp/save_payment/".$transaction->getTransDisplayId()."/".$payment->getType()."/".$payment->getAmount());
            }

            foreach ($items as $item) {
                // {trans_sys_id}/{prod_id}/{prod_name}/{orig_price}/{min_price}/{adjusted_price}/{discount_type}/{discount_value}
                file_get_contents("http://dev.gisterp2/pos_erp/save_item/".$transaction->getTransDisplayId()."/".$item->getProductId()."/".$item->getName()."/".$item->getOrigPrice()."/".$item->getMinimumPrice()."/".$item->getAdjustedPrice()."/".$item->getDiscountType()."/".$item->getDiscountValue());
            }

        }

        $em->flush();

        

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }
}
