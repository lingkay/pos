function freezeTransaction(is_final)
{
    is_final = is_final || false;
    var trans_saved = false;
    var items_saved = false;
    var payments_saved = false;
    var count_cart_items = $('#cart_items .product_row').length;
    var count_payments = $('#payments_table .init_row_payment').length;
    var pos_loc_id = $('#pos_loc_id').val();
    var transaction_total = $('#float_trans_amount').val();
    var transaction_ea = $('#float_trans_ea').val();
    var transaction_balance = $('#float_trans_balance').val();
    var transaction_mode = $('#string_trans_mode').val();
    var transaction_type = $('#string_trans_type').val();
    var bulk_type = $('#string_trans_bulk_type').val();
    var sel_bulk_type = $('#bulk_opt_sel').val();
    var sel_bulk_amount = $('#bulk_opt_amt').val();
    var transaction_tax_rate = $('#float_tax_rate').val();
    var transaction_orig_vat_amt = $('#float_orig_tax_vat_amt').val();
    var transaction_new_vat_amt = $('#float_new_tax_vat_amt').val();
    var transaction_orig_vat_amt_net = $('#float_orig_tax_amt_net_vat').val();
    var transaction_new_vat_amt_net = $('#float_new_tax_amt_net_vat').val();
    var transaction_tax_coverage = $('#string_tax_coverage').val();
    var transaction_cart_min_total = $('#float_cart_minimum_total').val();
    var transaction_cart_orig_total = $('#float_cart_orig_price').val();
    var transaction_cart_new_total = $('#float_cart_new_price').val();
    var transaction_cc_interest = $('#string_trans_cc_interest').val();
    var transaction_reference_sys_id = $('#transaction_reference_sys_id').val();
    var flag_upsell = $('#flag_upsell').val();
    var flag_refund = $('#flag_refund').val();
    var refund_method = $('#string_refund_method').val();
    var refund_amount = $('#float_trans_refund_amount').val();
    var deposit_amount = $('#float_trans_deposit_amount').val();
    var deposit_amt_net_vat = $('#float_deposit_tax_amt_net_vat').val();
    var deposit_vat_amt = $('#float_deposit_tax_vat_amt').val();
    var balance_amt_net_vat = $('#float_balance_tax_amt_net_vat').val();
    var balance_vat_amt = $('#float_balance_tax_vat_amt').val();
    var gc_credit = $('#float_trans_gc_credit').val();
    var gc_debit = $('#float_trans_gc_debit').val();
    var refund_reason = $('#cform-refund_reason').val();

    if(refund_reason.length < 1) {
        refund_reason = '%20';
    }

    //add gc topups to existing credit if there's any
    var current_credit = parseFloat(gc_credit);
    var additional_credit = 0;
    $('#cart_items tr').each(function() {
        var row = $(this).closest('tr');
        var barcode = row.find('.barcode').val();
        var srp = row.find('.srp').val();
        if (barcode == 'GC') {
            additional_credit = additional_credit + parseFloat(srp);
        }
        gc_credit = current_credit + additional_credit;
    });

    var exchange_flag = 'false';

    if (count_cart_items > 0 && transaction_mode == 'refund') {
        exchange_flag = 'true';
    }

    if (flag_refund == 'true') {
        transaction_total = $('#ovr_float_trans_amount').val();
        transaction_orig_vat_amt = $('#ovr_float_orig_tax_vat_amt').val();
        transaction_new_vat_amt = $('#ovr_float_new_tax_vat_amt').val();
        transaction_orig_vat_amt_net = $('#ovr_float_orig_tax_amt_net_vat').val();
        transaction_new_vat_amt_net = $('#ovr_float_new_tax_amt_net_vat').val();
        transaction_cart_orig_total = $('#ovr_float_cart_orig_price').val();
        transaction_cart_new_total = $('#ovr_float_cart_new_price').val();
    }


    var url_pos = $('#url_pos').val();
    var url_erp = $('#url_erp').val();

    var status = 'Frozen';
    if (is_final) {
        status = 'Paid';
    }
    var customer_id = $('#transaction_customer_id').val();

    var url = url_pos+"/pos/save_transaction/"+pos_loc_id+"/"+transaction_total+"/"+transaction_balance+"/"+transaction_type+"/"+customer_id+"/"+status+"/"+transaction_tax_rate+"/"+transaction_orig_vat_amt+"/"+transaction_new_vat_amt+"/"+transaction_orig_vat_amt_net+"/"+transaction_new_vat_amt_net+"/"+transaction_tax_coverage+"/"+transaction_cart_min_total+"/"+transaction_cart_orig_total+"/"+transaction_cart_new_total+"/"+bulk_type+"/"+transaction_mode+"/"+transaction_cc_interest+"/"+transaction_ea+"/"+deposit_amount+"/"+deposit_amt_net_vat+"/"+deposit_vat_amt+"/"+balance_amt_net_vat+"/"+balance_vat_amt+"/"+transaction_reference_sys_id+"/"+sel_bulk_type+"/"+sel_bulk_amount+"/"+flag_upsell+"/"+refund_method+"/"+refund_amount+"/"+exchange_flag+"/"+gc_credit+"/"+gc_debit+"/"+refund_reason;
    var x_new_id = '';

    $.getJSON(url, function(json){
        var count = 0;
        $.each(json, function(i, trans) {
            trans_saved = true;
            $('#transaction_system_id').val(trans.new_id);
            x_new_id = trans.new_id;

            // Save existing items
            $('#existing_cart_items tr').each(function() {
                var row = $(this).closest('tr');

                var product_id = row.find('.existing_product_id').val();
                var orig_price = row.find('.existing_srp').val();
                var min_price = row.find('.existing_min_price').val();
                var product_name = row.find('.existing_item_name').val();
                var barcode = row.find('.existing_barcode').val();
                var item_code = row.find('.existing_item_code').val();
                var discount_type = '%20';
                var discount_value = '%20';
                var adjusted_price = row.find('.existing_srp').val();
                var is_issued = 'true';
                var refund_issued = 'false';
                var issued_on = row.find('.existing_issued_on').val();

                if (transaction_mode != 'Deposit') {
                    issued_on = '%20';
                }

                if ($('#string_parent_trans_type').val() == "per") {
                    var indiv_disc_opt = row.find('.existing_indiv_disc_opt').val();
                    var per_item_discount_amt = row.find('.existing_per_item_discount_amt').val();
                    var adjusted_price_elem = row.find('.existing_adjusted_price').val();

                    if (indiv_disc_opt.length > 0) {
                        discount_type = indiv_disc_opt;
                    } else {
                        discount_type = '%20';
                    }

                    if (per_item_discount_amt.length > 0) {
                        discount_value = per_item_discount_amt;
                    } else {
                        discount_value = '%20';
                    }

                    if (adjusted_price_elem.length > 0) {
                        adjusted_price = adjusted_price_elem;
                    } else {
                        adjusted_price = '%20';
                    }
                }

                if (transaction_mode == 'Deposit') {
                    is_issued = 'false';
                }

                if (transaction_mode == 'frozen') {
                    is_issued = 'false';
                }

                if (row.find('.refund_issued').is(':checked')) {
                    refund_issued = 'true';
                }

                var url2 = url_pos + "/pos/save_item/" + trans.new_id + "/" + product_id + "/" + product_name + "/" + orig_price + "/" + min_price + "/" + adjusted_price + "/" + discount_type + "/" + discount_value + "/" + barcode + "/" + item_code + "/" + is_issued + "/" + issued_on + "/" + refund_issued;

                $.getJSON(url2, function (json) {
                    var count = 0;
                    $.each(json, function (i, items) {
                        items_saved = true;
                    });
                });

            });

            //save items
            if (count_cart_items > 0) {

                $('#cart_items tr').each(function() {
                    var row = $(this).closest('tr');

                    var product_id = row.find('.product_id').val();
                    var orig_price = row.find('.srp').val();
                    var min_price = row.find('.min_price').val();
                    var product_name = row.find('.item_name').val();
                    var barcode = row.find('.barcode').val();
                    var item_code = row.find('.item_code').val();
                    var discount_type = '%20';
                    var discount_value = '%20';
                    var adjusted_price = row.find('.srp').val();
                    var is_issued = 'true';
                    var refund_issued = 'new';
                    var issued_on = row.find('.issued_on').val();

                    if (transaction_mode != 'Deposit') {
                        issued_on = '%20';
                    }

                    if (transaction_type == "per") {
                        var indiv_disc_opt = row.find('.pos_indiv_discount_opt').val();
                        var per_item_discount_amt = row.find('.per_item_discount_amt').val();
                        var adjusted_price_elem = row.find('.adjusted_price').val();

                        if (indiv_disc_opt.length > 0) {
                            discount_type = indiv_disc_opt;
                        } else {
                            discount_type = '%20';
                        }

                        if (per_item_discount_amt.length > 0) {
                            discount_value = per_item_discount_amt;
                        } else {
                            discount_value = '%20';
                        }

                        if (adjusted_price_elem.length > 0) {
                            adjusted_price = adjusted_price_elem;
                        } else {
                            adjusted_price = '%20';
                        }
                    }

                    if (transaction_mode == 'Deposit') {
                        if (row.find('.check_issued').is(':checked')) {
                            is_issued = 'true';
                        } else {
                            is_issued = 'false';
                        }
                    }

                    if (transaction_mode == 'frozen') {
                        is_issued = 'false';
                    }

                    var url2 = url_pos + "/pos/save_item/" + trans.new_id + "/" + product_id + "/" + product_name + "/" + orig_price + "/" + min_price + "/" + adjusted_price + "/" + discount_type + "/" + discount_value + "/" + barcode + "/" + item_code + "/" + is_issued + "/" + issued_on + "/" + refund_issued;

                    $.getJSON(url2, function (json) {
                        var count = 0;
                        $.each(json, function (i, items) {
                            items_saved = true;
                        });
                    });

                });
            } else {
                // this is only for freezing a transaction without items
                // other transactions are not allowed to be processed and save without items
                items_saved = true;

                if (!is_final) {
                    swal({
                            title: "Transaction Frozen!",
                            text: "The page will now reload",
                            type: "success",
                            timer: 4000,
                            showConfirmButton: false,
                        },
                        function(){
                            syncToERP();
                        });
                } else {
                    swal({
                            title: "Transaction Saved!",
                            text: "Please wait for data sync",
                            type: "success",
                            timer: 4000,
                            showConfirmButton: false,
                        },
                        function(){
                            syncToERP();
                        });
                }
            }

            //save payments
            if (count_payments == 0 && transaction_type != 'none') {
                $('#payments_list tr').each(function() {
                    var payment_type = $(this).find('.payment_type').val();
                    var amount = $(this).find('.payment_amt_float').val();
                    var payment_issued_on = $(this).find('.payment_issued_on').val();

                    var control_number = "%20"; if($(this).find('.control_number').val() != ''){control_number = $(this).find('.control_number').val()};
                    var account_number = "%20"; if($(this).find('.account_number').val() != ''){account_number = $(this).find('.account_number').val()};
                    var bank = "%20"; if($(this).find('.bank').val() != ''){bank = $(this).find('.bank').val()};
                    var terminal_operator = "%20"; if($(this).find('.cc_terminal_opt').val() != ''){terminal_operator = $(this).find('.cc_terminal_opt').val()};
                    var cc_interest = "%20"; if($(this).find('.cc_interest').val() != ''){cc_interest = $(this).find('.cc_interest').val()};
                    var cc_terms = "%20"; if($(this).find('.cc_terms').val() != ''){cc_terms = $(this).find('.cc_terms').val()};
                    var payee = "%20"; if($(this).find('.payee').val() != ''){payee = $(this).find('.payee').val()};
                    var payor = "%20"; if($(this).find('.payor').val() != ''){payor = $(this).find('.payor').val()};
                    var cc_expiry = "%20"; if($(this).find('.cc_expiry').val() != ''){cc_expiry = $(this).find('.cc_expiry').val()};
                    var cc_cvv = "%20"; if($(this).find('.cc_cvv').val() != ''){cc_cvv = $(this).find('.cc_cvv').val()};

                    var check_type = "%20"; if($(this).find('.check_type').val() != ''){check_type = $(this).find('.check_type').val()};
                    var check_date = "%20"; if($(this).find('.check_date').val() != ''){check_date = $(this).find('.check_date').val()};

                    var url3 = url_pos+"/pos/save_payment/"+trans.new_id+"/"+payment_type+"/"+amount+"/"+control_number+"/"+bank+"/"+terminal_operator+"/"+cc_interest+"/"+cc_terms+"/"+account_number+"/"+payee+"/"+payor+"/"+cc_expiry+"/"+cc_cvv+"/"+payment_issued_on+"/"+check_type+"/"+check_date;

                    $.getJSON(url3, function(json){
                        var count = 0;
                        $.each(json, function(i, payments) {
                            //reload form
                            if (trans_saved) {

                                if (!items_saved) {
                                    setTimeout(
                                        function()
                                        {
                                            // timeout waiting for saving of items
                                        }, 2000);
                                }

                                if (!is_final) {
                                    swal({
                                            title: "Transaction Frozen!",
                                            text: "The page will now reload",
                                            type: "success",
                                            timer: 6000,
                                            showConfirmButton: false,
                                        },
                                        function(){
                                            syncToERP();
                                            //location.reload();

                                        });
                                } else {
                                    swal({
                                            title: "Transaction Saved!",
                                            text: "Please wait for data sync",
                                            type: "success",
                                            timer: 6000,
                                            showConfirmButton: false,
                                        },
                                        function(){
                                            syncToERP();
                                            //location.reload();

                                        });
                                }
                            } else {
                                if (!trans_saved) {
                                    swal('Error encountered!', 'There was a problem saving this transaction','error');
                                    location.reload();
                                }
                            }
                        });

                    });
                });
            } else {
                // when there are no payments made
                // this is only allowed for freezing transactions
                payments_saved = true;

                if (!is_final) {
                    swal({
                            title: "Transaction Frozen!",
                            text: "The page will now reload",
                            type: "success",
                            timer: 2000,
                            showConfirmButton: false,
                        },
                        function(){
                            syncToERP();
                            //location.reload();

                        });
                } else {
                    swal({
                            title: "Transaction Saved!",
                            text: "Please wait for data sync",
                            type: "success",
                            timer: 2000,
                            showConfirmButton: false,
                        },
                        function(){
                            syncToERP();
                            //location.reload();

                        });
                }
            }
        });

    });

    // save default split
    setTimeout(
        function()
        {
            var url_def_split = url_pos+"/pos/save_def_split/"+$('#transaction_system_id').val();
            //
            $.getJSON(url_def_split, function(json){
                $.each(json, function(i, resp) {
                    if (resp.status == 'saved') {

                    } else {

                    }
                });

            });
            //
        }, 4000);
}