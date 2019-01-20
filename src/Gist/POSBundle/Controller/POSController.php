<?php

namespace Gist\POSBundle\Controller;

use Gist\TemplateBundle\Model\BaseController as Controller;
use Gist\POSBundle\Entity\POSTransaction;
use Gist\POSBundle\Entity\POSTransactionItem;
use Gist\POSBundle\Entity\POSClock;
use Gist\POSBundle\Entity\POSTransactionPayment;
use Gist\POSBundle\Entity\POSTransactionSplit;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use DateTime;
use DateInterval;

/**
 * Class POSController
 * @package Gist\POSBundle\Controller
 */
class POSController extends Controller
{
    /**
     * Show the POS page
     */
    public function indexAction()
    {
    	$this->title = 'Dashboard';

        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $params['customer'] = null;
        $params['restrict'] = 'false';


        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    /**
     * Show the POS page with invalid transaction message
     */
    public function indexInvalidAction()
    {
        $this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $params['customer'] = null;
        $params['restrict'] = 'true';

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    /**
     * Show the POS page with a loaded transaction
     * @param $transaction_display_id
     * @return
     */
    public function indexLoadAction($transaction_display_id)
    {
        $em = $this->getDoctrine()->getManager();
        $this->title = 'Dashboard Loaded';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $transaction_object = $em->getRepository('GistPOSBundle:POSTransaction')
            ->findOneBy(array('trans_display_id' => $transaction_display_id));
        $params['transaction_object'] = null;
        $params['customer'] = null;
        $params['restrict'] = 'false';

        if ($transaction_object) {
            
            if ($transaction_object->hasChild()) {
            return $this->redirect($this->generateUrl('gist_pos_index_invalid'));
            }

            if ($transaction_object->getTransactionMode() != 'frozen' &&
                $transaction_object->getTransactionMode() != 'Deposit' &&
                $transaction_object->getTransactionMode() != 'normal') {
                return $this->redirect($this->generateUrl('gist_pos_index_invalid'));
            }
            $params['transaction_object'] = $transaction_object;
            $params['customer'] = $this->getCustomer($transaction_object->getCustomerId());
        }

        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    /**
     * @param $upsell_parent
     * @return mixed
     * @throws \Exception
     */
    public function indexLoadUpsellAction($upsell_parent)
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $this->title = 'Dashboard Loaded';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $transaction_object = $em->getRepository('GistPOSBundle:POSTransaction')
            ->findOneBy(array('id' => $upsell_parent));
        $params['transaction_object'] = null;
        $params['restrict'] = 'false';
        $params['flag_upsell'] = 'true';
        $params['upsell_parent'] = $upsell_parent;
        $params['customer'] = $this->getCustomer($transaction_object->getCustomerId());
        $params['ea'] = $transaction_object->getExtraAmount();

        // NOTE: check if selected transaction is still within upsell time limit
        $url=$conf->get('gist_sys_erp_url')."/inventory/pos/get/upsell_time";
        $result = file_get_contents($url);
        $upsell_seconds = json_decode($result, true);
        $date_orig = new DateTime();
        $date_orig = $date_orig->format('m/d/Y H:i:s');
        $date_end = $transaction_object
            ->getDateCreate()
            ->add(new DateInterval('PT'.$upsell_seconds.'S'))
            ->format('m/d/Y H:i:s'); // adds 674165 secs

        if ($date_end > $date_orig) {
            return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
        }

        $params['restrict'] = 'true';
        return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
    }

    /**
     * Show the POS page refund mode
     * @param $transaction_display_id
     * @return
     * @throws \Exception
     */
    public function indexLoadRefundAction($transaction_display_id)
    {
        $conf = $this->get('gist_configuration');
        $em = $this->getDoctrine()->getManager();
        $this->title = 'Dashboard Loaded';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        $params = $this->padFormParams($params);
        $transaction_object = $em->getRepository('GistPOSBundle:POSTransaction')
            ->findOneBy(array('trans_display_id' => $transaction_display_id));
        $params['transaction_object'] = null;
        $params['customer'] = null;
        $params['restrict'] = 'false';
        $params['flag_refund'] = 'true';
        $params['ea'] = $transaction_object->getExtraAmount();

        if ($transaction_object) {

            if ($transaction_object->hasChild()) {
                return $this->redirect($this->generateUrl('gist_pos_index_invalid'));
            }

            if ($transaction_object->getTransactionMode() != 'frozen' &&
                $transaction_object->getTransactionMode() != 'Deposit' &&
                $transaction_object->getTransactionMode() != 'normal') {
                return $this->redirect($this->generateUrl('gist_pos_index_invalid'));
            }
            $params['transaction_object'] = $transaction_object;
            $params['customer'] = $this->getCustomer($transaction_object->getCustomerId());
        }

        // check if selected transaction is still within upsell time limit
        $url_refund_days = $conf->get('gist_sys_erp_url')."/inventory/pos/get/refund_days";
        $result_refund_days = file_get_contents($url_refund_days);
        $refund_days = json_decode($result_refund_days, true);
        $date_orig = new DateTime();
        $date_orig = $date_orig->format('m/d/Y H:i:s');
        $date_end = $transaction_object
            ->getDateCreate()
            ->add(new DateInterval('P'.$refund_days.'D'))
            ->format('m/d/Y H:i:s'); // adds 674165 secs

        if ($date_end > $date_orig) {
            $url_refund_code = $conf->get('gist_sys_erp_url')."/inventory/pos/get/refund_code";
            $result_refund_code = file_get_contents($url_refund_code);
            $refund_code = json_decode($result_refund_code, true);
            $params['refund_code'] = $refund_code;
            return $this->render('GistPOSBundle:Dashboard:index_refund.html.twig', $params);
        } else {
            $params['restrict'] = 'expired';
            return $this->render('GistPOSBundle:Dashboard:index.html.twig', $params);
        }
    }

    /**
     * Generate parameters
     * @param $params
     * @param null $object
     * @return
     */
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

        $params['sys_pos_url'] = $conf->get('gist_sys_pos_url');
        $params['sys_erp_url'] = $conf->get('gist_sys_erp_url');
        $params['erp_gc_id'] = $conf->get('erp_gc_id');
        $params['pos_loc_id'] = $conf->get('gist_sys_pos_loc_id');

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

        $url_exchange_limit=$conf->get('gist_sys_erp_url')."/inventory/pos/get/exchange_rule_below";
        $result_exchange_limit = file_get_contents($url_exchange_limit);
        $var_exchange_limit = str_replace('"', '', $result_exchange_limit);

        $params['tax_coverage'] = $var_tax_coverage;
        $params['tax_rate'] = $var_tax_rate;
        $params['min_deposit_pct'] = $var_min_deposit;
        $params['exchange_limit'] = $var_exchange_limit;
        $params['cust_required_fields'] = $vars_req;
        $params['cust_visible_fields'] = $vars_visible;
        $params['bank_options'] = $vars;
        $params['terminal_operators'] = $vars2;
        $params['charge_rates'] = $opts;

        return $params;
    }

    /**
     * Get customer object
     * @param $id
     * @return null
     */
    protected function getCustomer($id)
    {
        $em = $this->getDoctrine()->getManager();
        $obj = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id'=>$id));
        if (!$obj) {
            return null;
        }

        return $obj;
    }

    /**
     * Show the landing page
     */
    public function landingAction()
    {
    	$this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        return $this->render('GistPOSBundle:Dashboard:main.html.twig', $params);
    }

    /**
     * Show the POS menu
     */
    public function posMenuAction()
    {
        $this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        return $this->render('GistPOSBundle:Dashboard:pos_menu.html.twig', $params);
    }

    /**
     * Show the POS menu
     */
    public function inventoryMenuAction()
    {
        $this->title = 'Dashboard';
        $params = $this->getViewParams('', 'gist_dashboard_index');
        return $this->render('GistPOSBundle:Dashboard:inventory_menu.html.twig', $params);
    }

    /**
     * Returns list of frozen transactions
     */
    public function getFrozenTransactionsAction()
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $frozen_transactions = $em->getRepository('GistPOSBundle:POSTransaction')->findBy(array('status'=>'Frozen'));
        $transactions = array();

        foreach ($frozen_transactions as $ft) {
            $transactions[] = array(
                'id'=>$ft->getID(),
                'disp_id'=>$ft->getTransDisplayId(),
                'date_created'=>$ft->getDateCreateFormatted3()
            );
        }

        return new JsonResponse($transactions);
    }

    public function getCustomerGCAction($cust_id)
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $customer = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id'=>$cust_id));

        if ($customer->getGCNumber()) {
            if ($customer->getGCNumber() == null) {
                $list_opts[] = array(
                    'gc_number'=>'N/A',
                    'gc_balance'=>'0.00',
                    'gc_expiry'=>'',
                    'gc_balance_formatted'=>'0,00',
                    'gc_name'=>'N/A'
                );

                return new JsonResponse($list_opts);
            }

            $gc_balance = $customer->getGCBalance();
            if ($gc_balance == null) {
                $gc_balance = 0;
            }
        } else {
            $gc_balance = 0;
        }

        $gc_balance_formatted = number_format($gc_balance, 2);

        $list_opts[] = array(
            'gc_number'=>$customer->getGCNumber(),
            'gc_balance'=>$gc_balance,
            'gc_expiry'=>$customer->getGCExpiry(),
            'gc_balance_formatted'=>$gc_balance_formatted,
            'gc_name'=>$customer->getGCName()
        );

        return new JsonResponse($list_opts);
    }

    public function getCustomerByGCAction($gc_number)
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $customer = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('gc_number'=>$gc_number));

        if (count($customer) < 1) {
            $list_opts[] = array('gc_number'=>'none','gc_balance'=>'0.00','gc_expiry'=>'');
            return new JsonResponse($list_opts);
        }

        $gc_balance = $customer->getGCBalance();
        if ($gc_balance == null) {
            $gc_balance = 0;
        }

        $gc_balance_formatted = number_format($gc_balance, 2);

        $list_opts[] = array(
            'gc_number'=>$customer->getGCNumber(),
            'gc_balance'=>$gc_balance,
            'gc_expiry'=>$customer->getGCExpiry(),
            'customer_id'=>$customer->getERPID(),
            'customer_name'=>$customer->getNameFormatted(),
            'gc_name'=>$customer->getGCName(),
            'gc_balance_formatted'=>$gc_balance_formatted
        );

        return new JsonResponse($list_opts);
    }

    public function saveCustomerGCAction($cust_id, $gc_number, $gc_name, $gc_expiry)
    {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $customer = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(array('erp_id'=>$cust_id));

        try {
            $customer->setGCNumber($gc_number);
            $customer->setGCName($gc_name);
            $customer->setGCExpiry($gc_expiry);

            $em->persist($customer);
            $em->flush();

            $list_opts[] = array('gc_saved'=>'true');
            return new JsonResponse($list_opts);
        } catch (\Exception $e) {
            $list_opts[] = array('gc_saved'=>'false');
            return new JsonResponse($list_opts);
        }
    }


    /**
     * Saving of POS transaction
     * (AJAX)
     * @param $total
     * @param $balance
     * @param $type
     * @param $customer_id
     * @param $status
     * @param $tax_rate
     * @param $orig_vat_amt
     * @param $new_vat_amt
     * @param $orig_amt_net_vat
     * @param $new_amt_net_vat
     * @param $tax_coverage
     * @param $cart_min
     * @param $orig_cart_total
     * @param $new_cart_total
     * @param $bulk_type
     * @param $transaction_mode
     * @param $transaction_cc_interest
     * @param $transaction_ea
     * @param $deposit_amount
     * @param $deposit_amt_net_vat
     * @param $deposit_vat_amt
     * @param $balance_amt_net_vat
     * @param $balance_vat_amt
     * @param $transaction_reference_sys_id
     * @param $selected_bulk_discount_type
     * @param $selected_bulk_discount_amount
     * @param $flag_upsell
     * @param $refundMethod
     * @param $refundAmount
     * @param $exchangeFlag
     * @param $gcCredit
     * @param $gcDebit
     * @param $refundReason
     * @return JsonResponse
     */
    public function saveTransactionAction(
        $pos_loc_id,
        $total,
        $balance,
        $type,
        $customer_id,
        $status,
        $tax_rate,
        $orig_vat_amt,
        $new_vat_amt,
        $orig_amt_net_vat,
        $new_amt_net_vat,
        $tax_coverage,
        $cart_min,
        $orig_cart_total,
        $new_cart_total,
        $bulk_type,
        $transaction_mode,
        $transaction_cc_interest,
        $transaction_ea,
        $deposit_amount,
        $deposit_amt_net_vat,
        $deposit_vat_amt,
        $balance_amt_net_vat,
        $balance_vat_amt,
        $transaction_reference_sys_id,
        $selected_bulk_discount_type,
        $selected_bulk_discount_amount,
        $flag_upsell,
        $refundMethod,
        $refundAmount,
        $exchangeFlag,
        $gcCredit,
        $gcDebit,
        $refundReason
    ) {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $transaction = new POSTransaction();

        if ($flag_upsell == 'true' && $transaction_mode == "Deposit") {

            $ref_transaction = $em->getRepository('GistPOSBundle:POSTransaction')
                ->findOneBy(['id'=>$transaction_reference_sys_id]);
            $new_id = $this->normalToUpsellAction($ref_transaction->getID());
            $transaction->setReferenceTransaction($new_id);
        } else {
            if ($transaction_reference_sys_id != "0") {
                $ref_transaction = $em->getRepository('GistPOSBundle:POSTransaction')
                    ->findOneBy(['id'=>$transaction_reference_sys_id]);
                $transaction->setReferenceTransaction($ref_transaction);
            }
        }

        $customer_object = $em->getRepository('GistPOSBundle:POSCustomer')->findOneBy(['erp_id'=>$customer_id]);

        $em->persist($transaction);
        $em->flush();

        $transaction->setRemarks($refundReason);
        $transaction->setCustomer($customer_object);
        $transaction->setCustomerId($customer_id);
        $transaction->setTransactionBalance($balance);
        $transaction->setTransactionTotal($total);
        $transaction->setTransactionType($type);
        $transaction->setStatus($status);
        $transaction->setSyncedToErp('false');
        $transaction->setTransactionMode($transaction_mode);
        $transaction->setExtraAmount($transaction_ea);
        $transaction->setLocation($pos_loc_id);
        $transaction->setRefundMethod($refundMethod);
        $transaction->setRefundAmount($refundAmount);
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
        $transaction->setGCCredit($gcCredit);
        $transaction->setGCDebit($gcDebit);

        // GC Balance manipulation
        if ($customer_object && $status != 'Frozen') {
            if ($customer_object->getGCNumber()) {
                if ($customer_object->getGCNumber() != '' && $customer_object->getGCNumber() != null) {
                    $current_balance = floatval($customer_object->getGCBalance());
                    $gcCredit = floatval($gcCredit);
                    $gcDebit = floatval($gcDebit);
                    $new_balance = $current_balance - $gcDebit;
                    $new_balance = $new_balance + $gcCredit;
                    $customer_object->setGCBalance($new_balance);
                    $em->persist($customer_object);

                }
            }
        }

        $em->persist($transaction);
        $em->flush();

        if ($exchangeFlag == 'true') {
            $new_display_id = 'E-'.str_pad($transaction->getID(),6,'0',STR_PAD_LEFT);
            $transaction->setTransactionMode('exchange');
        } else {
            $new_display_id = strtoupper(substr($transaction_mode, 0,1)) .
                '-' .
                str_pad($transaction->getID(),6,'0',STR_PAD_LEFT);
        }

        $transaction->setTransDisplayId($new_display_id);
        $em->persist($transaction);
        $em->flush();
        $list_opts[] = array('status'=>$transaction->getStatus(),'new_id'=>$transaction->getID());
        return new JsonResponse($list_opts);
    }

    /**
     * Generate default split
     * (AJAX)
     * @param $trans_sys_id
     * @return JsonResponse
     */
    public function generateDefaultSplitAction($trans_sys_id)
    {
        $split_trans_total = 0;
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->findOneBy(array('id'=>$trans_sys_id));

        if ($transaction->getTransactionMode() == 'exchange' || $transaction->getTransactionMode() == 'refund') {
            $split_trans_total = $transaction->getPaymentIssued();
            $split_entry = new POSTransactionSplit();
            $split_entry->setConsultant($this->getUser());
            $split_entry->setTransaction($transaction);
            $split_entry->setAmount($split_trans_total);
            if ($split_trans_total < 0) {
                $split_entry->setPercent('-100.00');
            } else {
                $split_entry->setPercent('100.00');
            }
            $em->persist($split_entry);

            $em->flush();
            $list_opts[] = array('status'=>'saved');
            return new JsonResponse($list_opts);
        }

        if ($transaction->getTransactionMode() != 'frozen' && $transaction->getTransactionMode() != 'quotation') {
            $ref = $transaction->getReferenceTransaction() ? $transaction->getReferenceTransaction() : null;
            if ($ref != null) {
                if ($transaction->getTransactionMode() == 'Deposit' || $ref->getTransactionMode() == 'Deposit') {
                    $split_trans_total = $transaction->getPaymentIssued();
                } else {
                    $split_trans_total = $transaction->getPaymentIssued();
                }
            } else {
                if ($transaction->getTransactionMode() == 'Deposit') {
                    $split_trans_total = $transaction->getPaymentIssued();
                } else {
                    $split_trans_total = $transaction->getPaymentIssued();
                }
            }

            $split_entry = new POSTransactionSplit();
            $split_entry->setConsultant($this->getUser());
            $split_entry->setTransaction($transaction);
            $split_entry->setAmount($split_trans_total);

            if ($split_trans_total < 0) {
                $split_entry->setPercent('-100.00');
            } else {
                $split_entry->setPercent('100.00');
            }

            $em->persist($split_entry);

            $em->flush();
            $list_opts[] = array('status'=>'saved');
            return new JsonResponse($list_opts);
        }

        $list_opts[] = array('status'=>'error');
        return new JsonResponse($list_opts);
    }

    /**
     * Save transaction items
     *
     * (AJAX)
     * @param $trans_sys_id
     * @param $prod_id
     * @param $prod_name
     * @param $orig_price
     * @param $min_price
     * @param $adjusted_price
     * @param $discount_type
     * @param $discount_value
     * @param $barcode
     * @param $item_code
     * @param $is_issued
     * @param $issued_on
     * @param $refund_issued
     * @return JsonResponse
     */
    public function saveTransactionItemsAction(
        $trans_sys_id,
        $prod_id,
        $prod_name,
        $orig_price,
        $min_price,
        $adjusted_price,
        $discount_type,
        $discount_value,
        $barcode,
        $item_code,
        $is_issued,
        $issued_on,
        $refund_issued
    ) {
        header("Access-Control-Allow-Origin: *");
        $em = $this->getDoctrine()->getManager();
        $transaction_item = new POSTransactionItem();

        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($trans_sys_id);

        if (trim($adjusted_price) == '' || $adjusted_price == null) {
            $adjusted_price = $orig_price;
        }

        if ($transaction->getTransactionType() == 'bulk') {

            $transactionTotalAmount = floatval($transaction->gettransactiontotal());
            $transactionOrigAmount = floatval($transaction->getCartOrigTotal());
            if ($transaction->getSelectedBulkDiscountType() == 'bdisc') {
                $bulkDiscountAmount = $transaction->getSelectedBulkDiscountAmount();
                $bulkDiscountedTotalAmount =
                    floatval($adjusted_price) - (floatval($adjusted_price) * (floatval($bulkDiscountAmount)/100));
                $transaction_item->setTotalAmount($bulkDiscountedTotalAmount);
            } elseif ($transaction->getSelectedBulkDiscountType() == 'bdiscamt') {
                $bulkDiscountAmount = floatval($transaction->getSelectedBulkDiscountAmount());
                $bulkDiscountPCTAmount = ($bulkDiscountAmount/$transactionOrigAmount) * 100;
                $bulkDiscountedTotalAmount =
                    floatval($adjusted_price) - (floatval($adjusted_price) * (floatval($bulkDiscountPCTAmount)/100));
                $transaction_item->setTotalAmount($bulkDiscountedTotalAmount);
            } elseif ($transaction->getSelectedBulkDiscountType() == 'bamt') {
                $bulkDiscountAmount = floatval($transaction->getSelectedBulkDiscountAmount());
                $bulkDiscountPCTAmount = ($bulkDiscountAmount/$transactionOrigAmount) * 100;
                $bulkDiscountedTotalAmount = floatval($adjusted_price) * (floatval($bulkDiscountPCTAmount)/100);
                $transaction_item->setTotalAmount($bulkDiscountedTotalAmount);
            } elseif ($transaction->getSelectedBulkDiscountType() == 'bgift') {
                $transaction_item->setTotalAmount(0.00);
            } else {
                $transaction_item->setTotalAmount($adjusted_price);
            }
        } else {
            $transaction_item->setTotalAmount($adjusted_price);
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
        $transaction_item->setReturned(false);

        if ($refund_issued == 'true') {
            $transaction_item->setReturned(true);
        } elseif ($refund_issued == 'new') {
            $transaction_item->setIsNewItem(true);
        } else {
            $transaction_item->setReturned(false);
        }

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

    /**
     * Save transaction payments
     * (AJAX)
     * @param $trans_sys_id
     * @param $payment_type
     * @param $amount
     * @param $control_number
     * @param $bank
     * @param $terminal_operator
     * @param $interest
     * @param $terms
     * @param $account_number
     * @param $payee
     * @param $payor
     * @param $expiry
     * @param $cvv
     * @param $issued_on
     * @param $check_type
     * @param $check_date
     * @return JsonResponse
     */
    public function saveTransactionPaymentsAction(
        $trans_sys_id,
        $payment_type,
        $amount,
        $control_number,
        $bank,
        $terminal_operator,
        $interest,
        $terms,
        $account_number,
        $payee,
        $payor,
        $expiry,
        $cvv,
        $issued_on,
        $check_type,
        $check_date
    ) {
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
        $transaction_payment->setCheckDate($check_date);
        $transaction_payment->setCheckType($check_type);
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

    /**
     * Send POS transactions to ERP
     * TODO: This should be a like a cron job and ERP should have PROPER API
     */
    public function syncDataAction()
    {
        try {
            $conf = $this->get('gist_configuration');
            header("Access-Control-Allow-Origin: *");
            $em = $this->getDoctrine()->getManager();

            $transactions = $em->getRepository('GistPOSBundle:POSTransaction')
                ->findBy(array('synced_to_erp' => 'false'));

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
                $pos_loc_id = $transaction->getLocation();

                if ($transaction->getReferenceTransaction() != null) {
                    $referenceTransaction = $transaction->getReferenceTransaction();
                    $referenceTransaction = $referenceTransaction->getERPID();
                } else {
                    $referenceTransaction = 'n-a';
                }

                if (trim($tax_rate) == '' || $tax_rate == null) {
                    $tax_rate = 'n-a';
                }
                if (trim($OrigVatAmt) == '' || $OrigVatAmt == null) {
                    $OrigVatAmt = 'n-a';
                }
                if (trim($NewVatAmt) == '' || $NewVatAmt == null) {
                    $NewVatAmt = 'n-a';
                }
                if (trim($OrigAmtNetVat) == '' || $OrigAmtNetVat == null) {
                    $OrigAmtNetVat = 'n-a';
                }
                if (trim($NewAmtNetVat) == '' || $NewAmtNetVat == null) {
                    $NewAmtNetVat = 'n-a';
                }
                if (trim($TaxCoverage) == '' || $TaxCoverage == null) {
                    $TaxCoverage = 'n-a';
                }
                if (trim($CartMin) == '' || $CartMin == null) {
                    $CartMin = 'n-a';
                }
                if (trim($CartOrigTotal) == '' || $CartOrigTotal == null) {
                    $CartOrigTotal = 'n-a';
                }
                if (trim($CartNewTotal) == '' || $CartNewTotal == null) {
                    $CartNewTotal = 'n-a';
                }
                if (trim($bulk_type) == '' || $bulk_type == null) {
                    $bulk_type = 'n-a';
                }
                if (trim($mode) == '' || $mode == null) {
                    $mode = 'n-a';
                }
                if (trim($cc_interest) == '' || $cc_interest == null) {
                    $cc_interest = 'n-a';
                }
                if (trim($ea) == '' || $ea == null) {
                    $ea = 'n-a';
                }

                // TODO: This MUST be converted to API
                $result1 = file_get_contents(
                    $conf->get('gist_sys_erp_url') .
                    "/pos_erp/save_transaction/" .
                    $pos_loc_id . "/" . $transaction->getID() .
                    "/" . $transaction->getTransDisplayId() .
                    "/" . $transaction->getTransactionTotal() .
                    "/" . $transaction->getTransactionBalance() .
                    "/" . $transaction->getTransactionType() .
                    "/" . $transaction->getCustomerId() .
                    "/" . $transaction->getStatus() .
                    "/" . $tax_rate .
                    "/" . $OrigVatAmt .
                    "/" . $NewVatAmt .
                    "/" . $OrigAmtNetVat .
                    "/" . $NewAmtNetVat .
                    "/" . $TaxCoverage .
                    "/" . $CartMin .
                    "/" . $CartOrigTotal .
                    "/" . $CartNewTotal .
                    "/" . $bulk_type .
                    "/" . $mode .
                    "/" . $cc_interest .
                    "/" . $ea .
                    "/" . $transaction->getUserCreate()->getERPID() .
                    "/" . $referenceTransaction
                );

                $result2 = json_decode($result1, true);

                $transaction->setERPID($result2[0]['new_id']);

                $transaction->setSyncedToErp('true');

                $em->persist($transaction);

                $payments = $em->getRepository('GistPOSBundle:POSTransactionPayment')
                    ->findBy(array('transaction' => $transaction));

                $items = $em->getRepository('GistPOSBundle:POSTransactionItem')
                    ->findBy(array('transaction' => $transaction));

                $splits = $em->getRepository('GistPOSBundle:POSTransactionSplit')
                    ->findBy(array('transaction' => $transaction));

                foreach ($payments as $payment) {
                    $bank = $payment->getBank();
                    $acct_num = $payment->getAccountNumber();
                    $terminal = $payment->getCardTerminalOperator();
                    $check_type = $payment->getCheckType();
                    $check_date = $payment->getCheckDate();
                    $control_number = $payment->getControlNumber();
                    $card_terms = $payment->getCardTerms();
                    if (trim($bank) == '' || $bank == null) {
                        $bank = 'n-a';
                    }
                    if (trim($acct_num) == '' || $acct_num == null) {
                        $acct_num = 'n-a';
                    }
                    if (trim($terminal) == '' || $terminal == null) {
                        $terminal = 'n-a';
                    }
                    if (trim($check_type) == '' || $check_type == null) {
                        $check_type = 'n-a';
                    }
                    if (trim($check_date) == '' || $check_date == null) {
                        $check_date = 'n-a';
                    }
                    if (trim($control_number) == '' || $control_number == null) {
                        $control_number = 'n-a';
                    }
                    if (trim($card_terms) == '' || $card_terms == null) {
                        $card_terms = 'n-a';
                    }
                    // TODO: This MUST be converted to API
                    file_get_contents(
                        $conf->get('gist_sys_erp_url') . "/pos_erp/save_payment/" .
                        $transaction->getTransDisplayId() .
                        "/" . $payment->getType() .
                        "/" . $payment->getAmount() .
                        "/" . $bank .
                        "/" . $terminal .
                        "/" . $check_type .
                        "/" . $check_date .
                        "/" . $control_number .
                        "/" . $acct_num .
                        "/" . $card_terms
                    );
                }

                foreach ($items as $item) {
                    $isRet = 'false';
                    if ($item->getReturned()) {
                        $isRet = 'true';
                    }

                    $isNew = 'false';
                    if ($item->getIsNewItem()) {
                        $isNew = 'true';
                    }
                    // TODO: This MUST be converted to API
                    file_get_contents(
                        $conf->get('gist_sys_erp_url') .
                        "/pos_erp/save_item/" .
                        $transaction->getTransDisplayId() .
                        "/" . $item->getProductId() .
                        "/" . $item->getName() .
                        "/" . $item->getOrigPrice() .
                        "/" . $item->getMinimumPrice() .
                        "/" . $item->getAdjustedPrice() .
                        "/" . $item->getTotalAmount() .
                        "/" . $item->getDiscountType() .
                        "/" . $item->getDiscountValue() .
                        "/" . $isRet .
                        "/" . $isNew
                    );
                }

                foreach ($splits as $split) {
                    // TODO: This MUST be converted to API
                    file_get_contents(
                        $conf->get('gist_sys_erp_url') .
                        "/pos_erp/save_split/" .
                        $transaction->getTransDisplayId() .
                        "/" . $split->getConsultant()->getERPID() .
                        "/" . $split->getAmount() .
                        "/" . $split->getPercent()
                    );
                }
            }

            $em->flush();

            $list_opts[] = array('status' => 'ok');
            return new JsonResponse($list_opts);
        } catch (\Exception $exception) {
            // TODO: Create flow for failed to sync.
            $list_opts[] = array('status' => 'ok');
            return new JsonResponse($list_opts);
        }
    }

    /**
     * @param int $id
     * @return mixed
     */
    public function printReceiptAction(int $id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        
        $params['transaction'] = $transaction;
        if ($transaction->getTransactionMode() == 'exchange' || $transaction->getTransactionMode() == 'refund') {
            $params['total_sales'] = $transaction->getTransactionTotal();
        } else {
            $params['total_sales'] = $transaction->getTransactionTotal();
        }

        $params['change'] = $transaction->getTransactionTotal() - $transaction->getTransactionBalance();

        $twig = 'GistPOSBundle:POS:receipt.html.twig';
        $pdf = $this->get('gist_pdf');
        $pdf->newPdf('pos_receipt');
        $html = $this->render($twig, $params);
        return $pdf->printPdf($html->getContent());
    }

    /**
     * Top Nav clock
     * (transfer to dashboard controller)
     * @param $type
     * @return JsonResponse
     * @throws \Exception
     */
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

    /**
     * Generates normal transaction from quotation
     */
    public function quoteToSaleAction($id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        $new_transaction = clone $transaction;
        $new_transaction->setReferenceTransaction($transaction);
        $em->persist($new_transaction);
        $em->flush();
        $new_display_id =
            strtoupper('N').'-'.str_pad($new_transaction->getID(),6,'0',STR_PAD_LEFT);
        $new_transaction->setTransDisplayId($new_display_id);
        $new_transaction->setTransactionMode('normal');
        $em->persist($new_transaction);
        $em->flush();
        $this->addFlash('success', 'Quotation converted to sale '.$new_transaction->getTransDisplayId());
        return $this->redirect($this->generateUrl('gist_pos_reports'));
    }

    /**
     * Generates upsell transaction from normal
     * @param int $id
     * @return
     */
    public function normalToUpsellAction(int $id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        $new_transaction = clone $transaction;
        $new_transaction->setReferenceTransaction($transaction);
        $em->persist($new_transaction);
        $em->flush();
        $new_display_id =
            strtoupper('U').'-'.str_pad($new_transaction->getID(),6,'0',STR_PAD_LEFT);
        $new_transaction->setTransDisplayId($new_display_id);
        $new_transaction->setTransactionMode('upsell');
        $em->persist($new_transaction);
        $em->flush();
        return $new_transaction;
    }

    /**
     * Deletes a transaction
     * (must not delete, use tagging instead)
     * @param int $id
     * @return
     */
    public function deleteTransactionAction(int $id)
    {
        $em = $this->getDoctrine()->getManager();
        $transaction_id = '';
        $transaction = $em->getRepository('GistPOSBundle:POSTransaction')->find($id);
        if ($transaction) {
            $transaction_id = $transaction->getTransDisplayId();
            $payments = $em->getRepository('GistPOSBundle:POSTransactionPayment')
                ->findBy(array('transaction'=>$transaction));
            $items = $em->getRepository('GistPOSBundle:POSTransactionItem')
                ->findBy(array('transaction'=>$transaction));

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
