<?php

namespace Gist\POSBundle\Controller;

// use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Gist\TemplateBundle\Model\BaseController as Controller;
use Gist\POSBundle\Entity\POSTransaction;
use Gist\POSBundle\Entity\POSTransactionItem;
use Gist\POSBundle\Entity\POSClock;
use Gist\POSBundle\Entity\POSTransactionPayment;
use Gist\POSBundle\Entity\POSTransactionSplit;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;

class POSController extends Controller
{
    public function indexAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $params['customer'] = null;
        $params['restrict'] = 'false';

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    public function indexInvalidAction()
    {
        $this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $params['customer'] = null;
        $params['restrict'] = 'true';

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    public function indexLoadAction($transaction_display_id)
    {
        $em = $this->getDoctrine()->getManager();
        $this->title = 'Dashboard Loaded';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $transaction_object = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(array('trans_display_id' => $transaction_display_id));
        $params['transaction_object'] = null;
        $params['customer'] = null;
        $params['restrict'] = 'false';

        

        if ($transaction_object) {
            
            if ($transaction_object->hasChild()) {
            return $this->redirect($this->generateUrl('gist_pos_index_invalid'));
            }

            if ($transaction_object->getTransactionMode() != 'frozen' && $transaction_object->getTransactionMode() != 'Deposit') {
                return $this->redirect($this->generateUrl('gist_pos_index_invalid'));
            }
            $params['transaction_object'] = $transaction_object;
            $params['customer'] = $this->getCustomer($transaction_object->getCustomerId());
        }
        

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    protected function padFormParams(&$params, $object = null)
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $params['indiv_options'] = array(
            'gift' => 'Gift/Free',
            'discamt' => 'Discount Amount',
            'disc' => 'Discount %',
            'chg' => 'Change of Price'
        );

        // arsers: ["visa", "amex", "mastercard", "discover", "generic"],
        $params['card_types'] = array(
            'visa'=>'Visa',
            'amex'=>'AMEX',
            'mastercard'=>'Mastercard',
            'discover'=>'Discover'
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

        $params['interest_opts'] = array(
            'with' => 'with interest',
            'without' => 'no interest'
        );

        $params['marital_options'] = array(
            'single' => 'Single',
            'married' => 'Married',
            'widow' => 'Widow'
        );

        $last_entry = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(array('transaction_mode' => 'normal'),array('id' => 'DESC'),1);
        if (count($last_entry) > 0) {
            $params['next_id'] = '005-' . str_pad($last_entry->getID() + 1,6,'0',STR_PAD_LEFT);
            $params['next_sys_id'] = $last_entry->getID() + 1;
        } else {
            $params['next_id'] = '005-' . str_pad(0 + 1,6,'0',STR_PAD_LEFT);
            $params['next_sys_id'] = "1";
        }

        $params['sys_pos_url'] = $conf->get('gist_sys_pos_url');
        $params['sys_erp_url'] = $conf->get('gist_sys_erp_url');



        $url=$conf->get('gist_sys_erp_url')."/inventory/pos/get/banks";
        $result = file_get_contents($url);
        $vars = json_decode($result, true);

        $url_req=$conf->get('gist_sys_erp_url')."/customer/fields/get_req";
        $result_req = file_get_contents($url_req);
        $vars_req = json_decode($result_req, true); 

        $url_visible=$conf->get('gist_sys_erp_url')."/customer/fields/get_visible";
        $result_visible = file_get_contents($url_visible);
        $vars_visible = json_decode($result_visible, true); 

        $url2=$conf->get('gist_sys_erp_url')."/inventory/pos/get/terminal_operators";
        $result2 = file_get_contents($url2);
        $vars2 = json_decode($result2, true);

        $url_chg=$conf->get('gist_sys_erp_url')."/pos_erp/get/charge_rates";
        $result_chg = file_get_contents($url_chg);
        $vars_chg = json_decode($result_chg, true);

        $opts = array();
        foreach ($vars_chg as $o)
            $opts[$o['id']] = $o['name'];


        $url_tax_coverage=$conf->get('gist_sys_erp_url')."/inventory/pos/get/tax_coverage";
        $result_tax_coverage = file_get_contents($url_tax_coverage);
        $var_tax_coverage = str_replace('"', '', $result_tax_coverage);

        $url_tax_rate=$conf->get('gist_sys_erp_url')."/inventory/pos/get/vat";
        $result_tax_rate = file_get_contents($url_tax_rate);
        $var_tax_rate = str_replace('"', '', $result_tax_rate);

        $url_min_dep=$conf->get('gist_sys_erp_url')."/inventory/pos/get/deposit_minimum";
        $result_min_dep = file_get_contents($url_min_dep);
        $var_min_deposit = str_replace('"', '', $result_min_dep);

        $params['tax_coverage'] = $var_tax_coverage;
        $params['tax_rate'] = $var_tax_rate;
        $params['min_deposit_pct'] = $var_min_deposit;

        $params['cust_required_fields'] = $vars_req;
        $params['cust_visible_fields'] = $vars_visible;
        $params['bank_options'] = $vars;
        $params['terminal_operators'] = $vars2;
        $params['charge_rates'] = $opts;

        
        return $params;
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

    public function landingAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        

        return $this->render('GistPOSBundle:Dashboard:main.html.twig', $params);
    }

    public function posMenuAction()
    {
        $this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');

        

        return $this->render('GistPOSBundle:Dashboard:pos_menu.html.twig', $params);
    }

    public function getFrozenTransactionsAction()
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $frozen_transactions = $em->getRepository('GistPOSBundle:POSTransaction')->findBy(array('status'=>'Frozen'));

        $transactions = array();

        foreach ($frozen_transactions as $ft) {
            $transactions[] = array('id'=>$ft->getID(), 'disp_id'=>$ft->getTransDisplayId(),'date_created'=>$ft->getDateCreateFormatted3());
        }

        return new JsonResponse($transactions);
    }


    // POS SAVING AND SENDING METHODS

    
    public function saveTransactionAction($id, $display_id, $total, $balance, $type, $customer_id, $status, $tax_rate, $orig_vat_amt, $new_vat_amt, $orig_amt_net_vat, $new_amt_net_vat, $tax_coverage, $cart_min, $orig_cart_total, $new_cart_total,$bulk_type,$transaction_mode,$transaction_cc_interest,$transaction_ea, $deposit_amount, $deposit_amt_net_vat ,$deposit_vat_amt, $balance_amt_net_vat, $balance_vat_amt, $transaction_reference_sys_id, $selected_bulk_discount_type, $selected_bulk_discount_amount)
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $transaction = new POSTransaction();

        if ($transaction_reference_sys_id != "0") {
            $ref_transaction = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(['id'=>$transaction_reference_sys_id]);
            $transaction->setReferenceTransaction($ref_transaction);
        }

        //$transaction->setId($id);
        //$transaction->setTransDisplayId($display_id);
        $transaction->setCustomerId($customer_id);
        $transaction->setTransactionBalance($balance);
        $transaction->setTransactionTotal($total);
        $transaction->setTransactionType($type);
        $transaction->setStatus($status);
        $transaction->setSyncedToErp('false');
        $transaction->setTransactionMode($transaction_mode);
        $transaction->setExtraAmount($transaction_ea);

        $transaction->setSelectedBulkDiscountType($selected_bulk_discount_type);
        $transaction->setSelectedBulkDiscountAmount($selected_bulk_discount_amount);

        $transaction->setDepositVatAmt($deposit_vat_amt);
        $transaction->setDepositAmtNetVat($deposit_vat_amt);
        $transaction->setBalanceVatAmt($balance_vat_amt);
        $transaction->setBalanceAmtNetVat($balance_amt_net_vat);
        $transaction->setBalance($balance);
        $transaction->setDepositAmount($deposit_amount);

        $transaction->setTaxRate($tax_rate);
        $transaction->setOrigVatAmt($orig_vat_amt);
        $transaction->setNewVatAmt($new_vat_amt);
        $transaction->setOrigAmtNetVat($orig_amt_net_vat);
        $transaction->setNewAmtNetVat($new_amt_net_vat);
        $transaction->setTaxCoverage($tax_coverage);
        $transaction->setCartMin($cart_min);
        $transaction->setCartOrigTotal($orig_cart_total);
        if ($new_cart_total == '0' && $type == 'per') {
            $transaction->setCartNewTotal($orig_cart_total);
        } else {
            $transaction->setCartNewTotal($new_cart_total);
        }
        $transaction->setBulkDiscountType($bulk_type);
        $transaction->setTransactionCCInterest($transaction_cc_interest);
        $transaction->setUserCreate($this->getUser());


        $em->persist($transaction);
        $em->flush();

        //action after save
        $new_display_id = strtoupper(substr($transaction_mode, 0,1)).'-'.str_pad($transaction->getID(),6,'0',STR_PAD_LEFT);
        $transaction->setTransDisplayId($new_display_id);
        $em->persist($transaction);
        $em->flush();

       

        $list_opts[] = array('status'=>$transaction->getStatus(),'new_id'=>$transaction->getID());
        return new JsonResponse($list_opts);
    }

    public function generateDefaultSplitAction($trans_sys_id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(array('id'=>$trans_sys_id));
         if ($transaction->getTransactionMode() != 'frozen' && $transaction->getTransactionMode() != 'quotation') {
            //add default split
            $split_trans_total = 0;
            $ref = $transaction->getReferenceTransaction() ? $transaction->getReferenceTransaction() : null;
            if ($ref != null) {
                if ($transaction->getTransactionMode() == 'Deposit' || $ref->getTransactionMode() == 'Deposit') {
                    $split_trans_total = $transaction->getTotalPayments();
                } else {
                    $split_trans_total = $transaction->getTotalPayments();
                }
            } else {
                if ($transaction->getTransactionMode() == 'Deposit') {
                    $split_trans_total = $transaction->getTotalPayments();
                } else {
                    $split_trans_total = $transaction->getTotalPayments();
                }
            }
                

            $split_entry = new POSTransactionSplit();
            //$consultant = $em->getRepository('GistUserBundle:User')->findOneBy(array('erp_id'=>$value));

            $split_entry->setConsultant($this->getUser());
            $split_entry->setTransaction($transaction);
            $split_entry->setAmount($split_trans_total);
            $split_entry->setPercent('100.00');
            $em->persist($split_entry);
            
            //die();
            $em->flush();   
        }
        $list_opts[] = array('status'=>'saved');
        return new JsonResponse($list_opts);
    }

    public function saveTransactionItemsAction($trans_sys_id, $prod_id, $prod_name, $orig_price, $min_price, $adjusted_price, $discount_type, $discount_value, $barcode, $item_code, $is_issued, $issued_on)
    {
        header("Access-Control-Allow-Origin: *");
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

        if ($is_issued == 'true') {
            $transaction_item->setIssued(true);
        } else {
            $transaction_item->setIssued(false);
        }

        

        
        $transaction_item->setTransaction($transaction);
        $transaction_item->setProductId($prod_id);
        $transaction_item->setOrigPrice($orig_price);
        $transaction_item->setMinimumPrice($min_price);
        $transaction_item->setAdjustedPrice($adjusted_price);
        $transaction_item->setName($prod_name);
        $transaction_item->setDiscountType($discount_type);
        $transaction_item->setDiscountValue($discount_value);

        $transaction_item->setBarcode($barcode);
        $transaction_item->setItemCode($item_code);

        $em->persist($transaction_item);
        $em->flush();

        if ($issued_on == 'this') {
            $transaction_item->setItemIssuedOn($transaction);
        } elseif ($issued_on != '0') {
            $ref_transaction = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(['id'=>$issued_on]);
            $transaction_item->setItemIssuedOn($ref_transaction);
        }

        $em->persist($transaction_item);
        $em->flush();

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }

    public function saveTransactionPaymentsAction($trans_sys_id, $payment_type, $amount, $control_number, $bank, $terminal_operator, $interest, $terms, $account_number, $payee, $payor, $expiry, $cvv, $issued_on)
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $transaction_payment = new POSTransactionPayment();

        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($trans_sys_id);
        
        $transaction_payment->setTransaction($transaction);
        $transaction_payment->setType($payment_type);
        $transaction_payment->setAmount($amount);

        $transaction_payment->setControlNumber($control_number);
        $transaction_payment->setBank($bank);
        $transaction_payment->setCardTerminalOperator($terminal_operator);
        $transaction_payment->setInterest($interest);
        $transaction_payment->setCardTerms($terms);
        $transaction_payment->setAccountNumber($account_number);
        $transaction_payment->setPayee($payee);
        $transaction_payment->setPayor($payor);
        $transaction_payment->setCardExpiry($expiry);
        $transaction_payment->setCardCvv($cvv);

        $em->persist($transaction_payment);
        $em->flush();

        if ($issued_on == '0') {
            $transaction_payment->setPaymentIssuedOn($transaction);
        } elseif ($issued_on != '0') {
            $ref_transaction = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(['id'=>$issued_on]);
            $transaction_payment->setPaymentIssuedOn($ref_transaction);
        }

        $em->persist($transaction_payment);
        $em->flush();

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }


    // SYNC TO ERP POS DATA
    public function syncDataAction()
    {
        $conf = $this->get('gist_configuration');
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();

        //send transactions
        $transactions = $em->getRepository('GistPOSBundle:POSTransaction')->findBy(array('synced_to_erp'=>'false'));
        
        //send items (loop transactions then loop items)
        //send payments (loop transactions then loop payments)
        

        foreach ($transactions as $transaction) {
            $tax_rate = $transaction->getTaxRate();
            $OrigVatAmt = $transaction->getOrigVatAmt();
            $NewVatAmt = $transaction->getNewVatAmt();
            $OrigAmtNetVat = $transaction->getOrigAmtNetVat();
            $NewAmtNetVat = $transaction->getNewAmtNetVat();
            $TaxCoverage = $transaction->getTaxCoverage();
            $CartMin = $transaction->getCartMin();
            $CartOrigTotal = $transaction->getCartOrigTotal();
            $CartNewTotal = $transaction->getCartNewTotal();
            $bulk_type = $transaction->getBulkDiscountType();
            $mode = $transaction->getTransactionMode();
            $cc_interest = $transaction->getTransactionCCInterest();
            $ea = $transaction->getExtraAmount();

            if (trim($tax_rate) == '' || $tax_rate == null) { $tax_rate = 'n-a'; }
            if (trim($OrigVatAmt) == '' || $OrigVatAmt == null) { $OrigVatAmt = 'n-a'; }
            if (trim($NewVatAmt) == '' || $NewVatAmt == null) { $NewVatAmt = 'n-a'; }
            if (trim($OrigAmtNetVat) == '' || $OrigAmtNetVat == null) { $OrigAmtNetVat = 'n-a'; }
            if (trim($NewAmtNetVat) == '' || $NewAmtNetVat == null) { $NewAmtNetVat = 'n-a'; }
            if (trim($TaxCoverage) == '' || $TaxCoverage == null) { $TaxCoverage = 'n-a'; }
            if (trim($CartMin) == '' || $CartMin == null) { $CartMin = 'n-a'; }
            if (trim($CartOrigTotal) == '' || $CartOrigTotal == null) { $CartOrigTotal = 'n-a'; }
            if (trim($CartNewTotal) == '' || $CartNewTotal == null) { $CartNewTotal = 'n-a'; }
            if (trim($bulk_type) == '' || $bulk_type == null) { $bulk_type = 'n-a'; }
            if (trim($mode) == '' || $mode == null) { $mode = 'n-a'; }
            if (trim($cc_interest) == '' || $cc_interest == null) { $cc_interest = 'n-a'; }
            if (trim($ea) == '' || $ea == null) { $ea = 'n-a'; }

            file_get_contents($conf->get('gist_sys_erp_url')."/pos_erp/save_transaction/".$transaction->getID()."/".$transaction->getTransDisplayId()."/".$transaction->getTransactionTotal()."/".$transaction->getTransactionBalance()."/".$transaction->getTransactionType()."/".$transaction->getCustomerId()."/".$transaction->getStatus()."/".$tax_rate."/".$OrigVatAmt."/".$NewVatAmt."/".$OrigAmtNetVat."/".$NewAmtNetVat."/".$TaxCoverage."/".$CartMin."/".$CartOrigTotal."/".$CartNewTotal."/".$bulk_type."/".$mode."/".$cc_interest."/".$ea);

            $transaction->setSyncedToErp('true');
            $em->persist($transaction);

            $payments = $em->getRepository('GistPOSBundle:POSTransactionPayment')->findBy(array('transaction'=>$transaction));
            $items = $em->getRepository('GistPOSBundle:POSTransactionItem')->findBy(array('transaction'=>$transaction));

            foreach ($payments as $payment) {
                // {trans_sys_id}/{payment_type}/{amount}
                file_get_contents($conf->get('gist_sys_erp_url')."/pos_erp/save_payment/".$transaction->getTransDisplayId()."/".$payment->getType()."/".$payment->getAmount());
            }

            foreach ($items as $item) {
                // {trans_sys_id}/{prod_id}/{prod_name}/{orig_price}/{min_price}/{adjusted_price}/{discount_type}/{discount_value}
                file_get_contents($conf->get('gist_sys_erp_url')."/pos_erp/save_item/".$transaction->getTransDisplayId()."/".$item->getProductId()."/".$item->getName()."/".$item->getOrigPrice()."/".$item->getMinimumPrice()."/".$item->getAdjustedPrice()."/".$item->getDiscountType()."/".$item->getDiscountValue());
            }

        }

        $em->flush();
        
        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }

    public function printReceiptAction($id)
    {
        $data = $this->getRequest()->request->all();


        
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        

        // $this->hookPreAction();
        $params['transaction'] = $transaction;
        $params['total_sales'] = $transaction->getTransactionTotal();
        $params['change'] = $transaction->getTransactionTotal() - $transaction->getTransactionBalance();

      
        $twig = 'GistPOSBundle:POS:receipt.html.twig';

        $pdf = $this->get('gist_pdf');
        $pdf->newPdf('pos_receipt');

        // // debug
        // return $this->render($twig, $params);

        $html = $this->render($twig, $params);
        return $pdf->printPdf($html->getContent());
    }

    public function clockAction($type)
    {
        $em = $this->getDoctrine()->getManager();
        $clock = new POSClock();

        $clock->setDate(new DateTime);
        $clock->setType($type);
        $clock->setUserId($this->getUser()->getId());

        $em->persist($clock);
        $em->flush();

        $list_opts[] = array('status'=>'ok');
        return new JsonResponse($list_opts);
    }

    public function quoteToSaleAction($id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);

        $new_transaction = clone $transaction;
        $new_transaction->setReferenceTransaction($transaction);
        $em->persist($new_transaction);
        $em->flush();

        $new_display_id = strtoupper('N').'-'.str_pad($new_transaction->getID(),6,'0',STR_PAD_LEFT);
        $new_transaction->setTransDisplayId($new_display_id);
        $new_transaction->setTransactionMode('normal');
        $em->persist($new_transaction);
        $em->flush();

        $this->addFlash('success', 'Quotation converted to sale '.$new_transaction->getTransDisplayId());
        return $this->redirect($this->generateUrl('gist_pos_reports'));
    }

    public function deleteTransactionAction($id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction_id = '';


        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        if ($transaction) {
            $transaction_id = $transaction->getTransDisplayId();
            $payments = $em->getRepository('GistPOSBundle:POSTransactionPayment')->findBy(array('transaction'=>$transaction));
            $items = $em->getRepository('GistPOSBundle:POSTransactionItem')->findBy(array('transaction'=>$transaction));

            foreach ($payments as $payment) {
                $em->remove($payment);
            }

            foreach ($items as $item) {
                $em->remove($item);
            }

            $em->remove($transaction);
            $em->flush();

            $this->addFlash('success', 'Transaction ' . $transaction_id . ' deleted!');
            return $this->redirect($this->generateUrl('gist_pos_reports'));
        }

        $this->addFlash('success', 'Transaction not found!');
        return $this->redirect($this->generateUrl('gist_pos_reports'));
    }
}
