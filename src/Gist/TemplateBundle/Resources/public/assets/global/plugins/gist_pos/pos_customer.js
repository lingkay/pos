function ajaxSearchCustomer()
{
    var first_name = "%20";
    if ($('#cform-cust_search_firstname').length) {
        if($('#cform-cust_search_firstname').val() != ''){first_name = $('#cform-cust_search_firstname').val()};
    }
    var middle_name = "%20";
    if ($('#cform-cust_search_middle_name').length) {
        if($('#cform-cust_search_middle_name').val() != ''){middle_name = $('#cform-cust_search_middle_name').val()};
    }
    var last_name = "%20";
    if ($('#cform-cust_search_lastname').length) {
        if($('#cform-cust_search_lastname').val() != ''){last_name = $('#cform-cust_search_lastname').val()};
    }
    var email = "%20";
    if ($('#cform-cust_search_email').length) {
        if($('#cform-cust_search_email').val() != ''){email = $('#cform-cust_search_email').val()};
    }
    var number = "%20";
    if ($('#cform-cust_search_mobile').length) {
        if($('#cform-cust_search_mobile').val() != ''){number = $('#cform-cust_search_mobile').val()};
    }

    var customer_id = "%20";
    if ($('#cform-cust_search_id').length) {
        if($('#cform-cust_search_id').val() != ''){customer_id = $('#cform-cust_search_id').val()};
    }
    var gender = "%20";
    if ($('#cform-cust_search_gender').length) {
        if($("input[name='cust_search_gender']").is(":checked")){gender = $("input[name='cust_search_gender']:checked").val()} ;
    }
    var marital_status = "%20";
    if ($('#cform-cust_search_marital').length) {
        if($('.cust_search_marital').val() != '' && $('.cust_search_marital').val() != 'undefined'){marital_status = $('.cust_search_marital').val()};
    }
    var date_married = "%20";
    if ($('#cform-cust_search_marriage_date').length) {
        if($('#cform-cust_search_marriage_date').val() != ''){date_married = $('#cform-cust_search_marriage_date').val()};
    }
    var home_phone = "%20";
    if ($('#cform-cust_search_home_phone').length) {
        if($('#cform-cust_search_home_phone').val() != ''){home_phone = $('#cform-cust_search_home_phone').val()};
    }
    var birthday = "%20";
    if ($('#cform-cust_search_birthdate').length) {
        if($('#cform-cust_search_birthdate').val() != ''){birthday = $('#cform-cust_search_birthdate').val()};
    }
    var address1 = "%20";
    if ($('#cform-cust_search_address_1').length) {
        if($('#cform-cust_search_address_1').val() != ''){address1 = $('#cform-cust_search_address_1').val()};
    }
    var address2 = "%20";
    if ($('#cform-cust_search_address_2').length) {
        if($('#cform-cust_search_address_2').val() != ''){address2 = $('#cform-cust_search_address_2').val()};
    }

    var city = "%20";
    if ($('#cform-cust_search_city').length) {
        if($('#cform-cust_search_city').val() != ''){city = $('#cform-cust_search_city').val()};
    }
    var state = "%20";
    if ($('#cform-cust_search_state').length) {
        if($('#cform-cust_search_state').val() != ''){state = $('#cform-cust_search_state').val()};
    }
    var country = "%20";
    if ($('#cform-cust_search_country').length) {
        if($('#cform-cust_search_country').val() != ''){country = $('#cform-cust_search_country').val()};
    }
    var zip = "%20";
    if ($('#cform-cust_search_zip').length) {
        if($('#cform-cust_search_zip').val() != ''){zip = $('#cform-cust_search_zip').val()};
    }
    var notes = "%20";
    if ($('#cform-cust_search_notes').length) {
        if($('#cform-cust_search_notes').val() != ''){notes = $('#cform-cust_search_notes').val()};
    }

    $('#customers_list').empty();

    var url_pos = $('#url_pos').val();
    var url_erp = $('#url_erp').val();

    var url = url_erp+"/customer/pos/search/"+first_name+"/"+last_name+"/"+email+"/"+number+"/"+middle_name+"/"+customer_id+"/"+gender+"/"+marital_status+"/"+date_married+"/"+home_phone+"/"+birthday+"/"+address1+"/"+address2+"/"+city+"/"+state+"/"+country+"/"+zip;

    url.replace('%2F','');
    $.getJSON(url, function(json){
        var count = 0;
        $.each(json, function(i, cust) {
            count++;
            var name = cust.last_name + ', ' + cust.first_name;

            $('.init_row_customer').remove();
            var field = '<tr class=\"row_cust_'+cust.id+'\">';
            field += '<input type="hidden" class="first_name" value="'+cust.first_name+'">';
            field += '<input type="hidden" class="last_name" value="'+cust.last_name+'">';
            field += '<input type="hidden" class="email" value="'+cust.email+'">';
            field += '<input type="hidden" class="number" value="'+cust.number+'">';
            field += '<input type="hidden" class="middle_name" value="'+cust.middle_name+'">';
            field += '<input type="hidden" class="id" value="'+cust.id+'">';
            field += '<input type="hidden" class="gender" value="'+cust.gender+'">';
            field += '<input type="hidden" class="marital_status" value="'+cust.marital_status+'">';
            field += '<input type="hidden" class="date_married" value="'+cust.date_married+'">';
            field += '<input type="hidden" class="home_phone" value="'+cust.home_phone+'">';
            field += '<input type="hidden" class="birthdate" value="'+cust.birthdate+'">';
            field += '<input type="hidden" class="address1" value="'+cust.address1+'">';
            field += '<input type="hidden" class="address2" value="'+cust.address2+'">';
            field += '<input type="hidden" class="city" value="'+cust.city+'">';
            field += '<input type="hidden" class="state" value="'+cust.state+'">';
            field += '<input type="hidden" class="country" value="'+cust.country+'">';
            field += '<input type="hidden" class="zip" value="'+cust.zip+'">';
            field += '<input type="hidden" class="notes" value="'+cust.notes+'">';
            //  field += '<input type="hidden" class="gc_number" value="'+cust.notes+'">';
            // field += '<input type="hidden" class="gc_balance" value="'+cust.notes+'">';
            // field += '<input type="hidden" class="gc_expiry" value="'+cust.notes+'">';
            field += '<input type="hidden" class="display_id" value="'+cust.display_id+'">';
            field += '<td><input type="text" style=\"font-size: 12px !important;\" name="customer_name[]" value="'+name+'" readonly="true" class="form-control customer_name"></td>';
            field += '<td><input type="text" style=\"font-size: 12px !important;\" name="customer_email[]" class="form-control customer_email" readonly="true" value="'+cust.email+'">';
            field += '<td><a href="javascript:void(0)" class="btn btn-xs view_customer_btn" data-toggle="tooltip" data-placement="bottom" title="View Customer"><i class="fa fa-eye" aria-hidden="true"></i></a>';
            field += '<a href="javascript:void(0)" class="btn btn-xs use_customer_btn" data-toggle="tooltip" data-placement="bottom" title="Select Customer"><i class="fa fa-user" aria-hidden="true"></i></a></td>';
            field += '</tr>';

            $('#customers_list').prepend(field);

        });

        if (count == 0) {
            var field = '<tr class=\"init_row_prods\">';
            field += '<td colspan=\"3\"><p>No customer found &nbsp;&nbsp;&nbsp;</p></td>';
            field += '</tr>';

            $('#customers_list').prepend(field);
            swal('No customer found!', '', 'error');
        } else {
            var objDiv = document.getElementById("cust_formx");
            objDiv.scrollTop = objDiv.scrollHeight;
        }
    });
}

function ajaxAddCustomer()
{

    var first_name = "%20";
    if ($('#cform-cust_search_firstname').length) {
        if($('#cform-cust_search_firstname').val() != ''){first_name = $('#cform-cust_search_firstname').val()};
    }
    var middle_name = "%20";
    if ($('#cform-cust_search_middle_name').length) {
        if($('#cform-cust_search_middle_name').val() != ''){middle_name = $('#cform-cust_search_middle_name').val()};
    }
    var last_name = "%20";
    if ($('#cform-cust_search_lastname').length) {
        if($('#cform-cust_search_lastname').val() != ''){last_name = $('#cform-cust_search_lastname').val()};
    }
    var email = "%20";
    if ($('#cform-cust_search_email').length) {
        if($('#cform-cust_search_email').val() != ''){email = $('#cform-cust_search_email').val()};
    }
    var number = "%20";
    if ($('#cform-cust_search_mobile').length) {
        if($('#cform-cust_search_mobile').val() != ''){number = $('#cform-cust_search_mobile').val()};
    }

    var customer_id = "%20";
    if ($('#cform-cust_search_id').length) {
        if($('#cform-cust_search_id').val() != ''){customer_id = $('#cform-cust_search_id').val()};
    }
    var gender = "%20";
    if ($('#cform-cust_search_gender').length) {
        if($("input[name='cust_search_gender']").is(":checked")){gender = $("input[name='cust_search_gender']:checked").val()} ;
    }
    var marital_status = "%20";
    if ($('#cform-cust_search_marital').length) {
        if($('.cust_search_marital').val() != '' && $('.cust_search_marital').val() != 'undefined'){marital_status = $('.cust_search_marital').val()};
    }
    var date_married = "%20";
    if ($('#cform-cust_search_marriage_date').length) {
        if($('#cform-cust_search_marriage_date').val() != ''){date_married = $('#cform-cust_search_marriage_date').val()};
    }
    var home_phone = "%20";
    if ($('#cform-cust_search_home_phone').length) {
        if($('#cform-cust_search_home_phone').val() != ''){home_phone = $('#cform-cust_search_home_phone').val()};
    }
    var birthday = "%20";
    if ($('#cform-cust_search_birthdate').length) {
        if($('#cform-cust_search_birthdate').val() != ''){birthday = $('#cform-cust_search_birthdate').val()};
    }
    var address1 = "%20";
    if ($('#cform-cust_search_address_1').length) {
        if($('#cform-cust_search_address_1').val() != ''){address1 = $('#cform-cust_search_address_1').val()};
    }
    var address2 = "%20";
    if ($('#cform-cust_search_address_2').length) {
        if($('#cform-cust_search_address_2').val() != ''){address2 = $('#cform-cust_search_address_2').val()};
    }

    var city = "%20";
    if ($('#cform-cust_search_city').length) {
        if($('#cform-cust_search_city').val() != ''){city = $('#cform-cust_search_city').val()};
    }
    var state = "%20";
    if ($('#cform-cust_search_state').length) {
        if($('#cform-cust_search_state').val() != ''){state = $('#cform-cust_search_state').val()};
    }
    var country = "%20";
    if ($('#cform-cust_search_country').length) {
        if($('#cform-cust_search_country').val() != ''){country = $('#cform-cust_search_country').val()};
    }
    var zip = "%20";
    if ($('#cform-cust_search_zip').length) {
        if($('#cform-cust_search_zip').val() != ''){zip = $('#cform-cust_search_zip').val()};
    }
    var notes = "%20";
    if ($('#cform-cust_search_notes').length) {
        if($('#cform-cust_search_notes').val() != ''){notes = $('#cform-cust_search_notes').val()};
    }
    var consultant_id = "%20";
    if ($('#string_consultant_id').length) {
        if($('#string_consultant_id').val() != ''){consultant_id = $('#string_consultant_id').val()};
    }

    var url_pos = $('#url_pos').val();
    var url_erp = $('#url_erp').val();
    var url = url_erp+"/customer/pos/add/"+first_name+"/"+last_name+"/"+email+"/"+number+"/"+middle_name+"/"+gender+"/"+marital_status+"/"+date_married+"/"+home_phone+"/"+birthday+"/"+address1+"/"+address2+"/"+city+"/"+state+"/"+country+"/"+zip+"/"+notes+"/"+consultant_id;

    $.getJSON(url, function(json){
        var count = 0;
        $.each(json, function(i, cust) {


            var route2 = url_pos+"/settings/sync_customers";
            $.getJSON(route2, function(json2){
                $.each(json2, function(i, x) {
                    swal("Success!", 'Customer added!',"success");
                    $('#transaction_customer_id').val(cust.new_customer_id);
                    $('#customer_modal').modal('hide');

                    if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0) {

                        $('#final_modal').modal('show');
                    }
                });
            });


        });
    });
    //here
    var name_fmtd = last_name+", "+first_name;
    $('#footer_customer').text(name_fmtd);
    clearCustomerAdd();
}

function clearCustomerAdd()
{
    $('#cform-cust_firstname').val('');
    $('#cform-cust_lastname').val('');
    $('#cform-cust_email').val('');
    $('#cform-cust_mobile').val('');
}

function resetCustomerModal()
{
    clearCustomerFields();
    $('#customer_modal').modal('hide');
    $('.customer_seach_main_div').show();
    $('.customer_search_btn').show();
    $('.customer_clear_search_btn').show();
    $('.add_customer').show();
    $('.customer_continue_btn').hide();
    $('.customer_search_again_btn').hide();

    $('#customers_list').empty();
    var field = '<tr class=\"init_row_prods\">';
    field += '<td colspan=\"3\"><p>No customer found &nbsp;&nbsp;&nbsp;</p></td>';
    field += '</tr>';

    $('#customers_list').prepend(field);
}

function clearCustomerFields()
{
    $('.cust_search_gender').prop('checked', false);
    $('#uniform-cform-cust_search_gender > span').removeClass('checked');
    $('#cform-cust_search_id').val('');
    $('#cform-cust_search_firstname').val('');
    $('#cform-cust_search_middle_name').val('');
    $('#cform-cust_search_lastname').val('');
    $('#cform-cust_search_home_phone').val('');
    $('#cform-cust_search_mobile').val('');
    $('#cform-cust_search_email').val('');
    $('#cform-cust_search_birthdate').val('');
    $('#cform-cust_search_address_1').val('');
    $('#cform-cust_search_address_2').val('');
    $('#cform-cust_search_city').val('');
    $('#cform-cust_search_state').val('');
    $('#cform-cust_search_country').val('');
    $('#cform-cust_search_zip').val('');
    $('#cform-cust_search_marriage_date').val('');
    $('#cform-notes').val('');
    $('.cust_search_marital').prop('selectedIndex',0);
    $('.posgrp_cust_search_marriage_date').hide();
}

/* GC */
function getCustomerGCInfo(cust_id)
{
    var url_pos = $('#url_pos').val();
    var url = url_pos+"/pos/get_customer_gc/"+cust_id;

    $.getJSON(url, function(json) {
        $.each(json, function (i, cust) {

            $('#transaction_gc_number').val(cust.gc_number);
            $('#transaction_gc_expiry').val(cust.gc_expiry);
            $('#transaction_gc_balance').val(cust.gc_balance);
            $('#header_gc_number').text(cust.gc_number);
            $('#header_gc_balance').text(" (Php " + cust.gc_balance_formatted + ")");
        });
    });
}

function autoloadGCModalInfo()
{
    //assign customer gc details
    var url_pos = $('#url_pos').val();
    var cust_id = $('#transaction_customer_id').val();
    var url = url_pos+"/pos/get_customer_gc/"+cust_id;

    $.getJSON(url, function(json) {
        $.each(json, function (i, cust) {
            if (cust.gc_number == 'N/A') {
                swal('Card not found!','Please try again','error');
                $('#cform-gc_card_number').val('');
                $('#cform-gcp_balance').val('');
                $('#cform-gcp_card_name').val('');
            } else {
                swal('Customer gift card detected!','','success');
                $('#cform-gc_card_number').val(cust.gc_number);
                $('#cform-gcp_balance').val(cust.gc_balance);
                $('#cform-gcp_card_name').val(cust.gc_name);
            }
        });
    });
    //end
}

function clearGiftCardModal()
{
    $('#cform-gcp_pay_amt').val('');
    $('#cform-gcp_debit_amt').val('');
    $('#cform-gc_card_number').val('');
    $('#cform-gc_card_name').val('');
    $('#cform-gc_card_expiry').val('');
}

function proceedRefund(method)
{
    if (method == "gc") {

        var trans_gc = $('#transaction_gc_number').val();

        if (trans_gc == '0' || trans_gc == 'N/A') {
            swal('Customer has no Gift Card!','','error');
            return 0;
        } else {
            $('#cform-gcr_card_number').val(trans_gc);
        }

        var refund_orig_total = 0;

        //get payments not made thru GC
        var other_payments = 0;
        var count_other_payments = 0;
        var count_gc_payments = 0;
        $('#payments_list tr').each(function() {
            var type = $(this).find('.payment_type').val();
            var payment_amt = parseFloat($(this).find('.payment_amt_float').val());
            if (type != 'Gift Card') {
                count_other_payments++;
                other_payments = other_payments + payment_amt;
            } else if (type == 'Gift Card') {
                count_gc_payments++;
            }
        });

        if (count_other_payments == 0) {
            //GC payment only, refer to original prices
            $('.refund_issued:checkbox:checked').each(function () {
                var row = $(this).closest('.existing_product_row');
                var ext_srp = row.find('.existing_srp');
                refund_orig_total += parseFloat(ext_srp.val());
                //console.log('ext srp' + parseFloat(ext_srp.val()));
            });
        } else {
            //Mixed payments, refer to adjusted prices if there's any
            $('.refund_issued:checkbox:checked').each(function () {
                var row = $(this).closest('.existing_product_row');
                if ($('#string_parent_trans_type').val() == 'per') {
                    var ext_srp = row.find('.existing_adjusted_price');
                } else {
                    var ext_srp = row.find('.existing_srp');
                }

                refund_orig_total += parseFloat(ext_srp.val());
            });

            if ($('#string_parent_trans_type').val() == 'per') {
                refund_orig_total = refund_orig_total - other_payments;
            }

        }
        //console.log('refund_orig_total from [1]: ' + refund_orig_total);

        var refund_amt = parseFloat($('#float_trans_balance').val());
        refund_amt = Math.abs(refund_amt);

        var bulk_option = $('#bulk_opt_sel').val();
        var bulk_amt = $('#bulk_opt_amt').val();
        if (bulk_option != 'none') {
            if (bulk_option == 'bdiscamt') {
                refund_orig_total = refund_orig_total - parseFloat(bulk_amt);
            } else if (bulk_option == 'bdisc') {
                refund_orig_total = refund_orig_total - (refund_orig_total * (bulk_amt/100));

            } else if (bulk_option == 'bamt') {
                refund_orig_total = bulk_amt; //not sure
            } else {
                refund_orig_total = 0;
            }

            if (count_other_payments > 0) {
                var refund_orig_total_less_others = refund_orig_total - other_payments;
                var trans_orig_price = parseFloat($('#float_static_trans_orig_price').val());
                trans_percent_discount = ((trans_orig_price - refund_orig_total) / trans_orig_price) * 100;
                refund_orig_total = refund_orig_total_less_others + (refund_orig_total_less_others * (trans_percent_discount / 100));
            }
        } else {
            if ($('#string_parent_trans_type').val() == 'per') {
                //compute percentage accounting other payments
                if (count_other_payments > 0) {
                    var trans_percent_discount = 0;
                    var trans_orig_price = parseFloat($('#float_static_trans_orig_price').val());
                    var trans_new_price = parseFloat($('#float_static_trans_amount').val());
                    trans_percent_discount = ((trans_orig_price - trans_new_price) / trans_orig_price) * 100;
                    refund_orig_total = refund_orig_total + (refund_orig_total * (trans_percent_discount/100));
                }
            }
        }

        if (count_other_payments > 0 && count_gc_payments > 0) {
            refund_orig_total = refund_orig_total + other_payments;
            console.log('refund_orig_total add other: ' + refund_orig_total);
        }


        //for additional neww items cart
        var percentage = 0;
        var amt_to_pay = parseFloat($('#float_trans_amount').val());
        var count_cart_items = $('#cart_items .product_row').length;

        if (count_cart_items > 0) {
            // get percentage
            percentage = (refund_amt/amt_to_pay)*100;
            console.log(percentage);
            // compute from original price
            refund_orig_total = refund_orig_total*(percentage/100);
        }

        //ADD payments not made thru GC


        $('#string_refund_method').val('Gift Card');
        $('#float_trans_gc_credit').val(refund_orig_total);
        $('#cform-gcr_refund_amt').val(addCommas(refund_amt));
        $('#cform-gcr_credit_amt').val(addCommas(refund_orig_total));
        $('#refund_type_modal').modal('hide');
        $('#gc_refund_modal').modal('show');
    } else if (method == "cash") {
        $('#string_refund_method').val('Cash');
        $('#refund_type_modal').modal('hide');
        $('#final_modal').modal('show');
    } else if (method == "credit") {
        $('#string_refund_method').val('Credit Card');
        $('#refund_type_modal').modal('hide');
        $('#final_modal').modal('show');
    } else if (method == "check") {
        $('#string_refund_method').val('Check');
        $('#refund_type_modal').modal('hide');
        $('#final_modal').modal('show');
    }
}