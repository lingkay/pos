function computeVATDeposit(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;
    total = parseFloat(total);

    $('.totals_deposit_amt').text(addCommas(total));

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#float_deposit_tax_amt_net_vat').val(amt_net_of_vat);
        $('#float_deposit_tax_vat_amt').val(vat_amt);
        $("#deposit_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#deposit_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_deposit_tax_amt_net_vat').val(amt_net_of_vat);
        $('#float_deposit_tax_vat_amt').val(vat_amt);
        $("#deposit_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#deposit_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {

    }


}

function computeVATBalance(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;

    $('.totals_balance').text(addCommas(total));

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#float_balance_tax_vat_amt').val(vat_amt);
        $('#float_balance_tax_amt_net_vat').val(amt_net_of_vat);
        $("#balance_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#balance_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_balance_tax_vat_amt').val(vat_amt);
        $('#float_balance_tax_amt_net_vat').val(amt_net_of_vat);
        $("#balance_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#balance_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {

    }


}


$(document).ready(function(){ 

    $('#cform-cust_search_id').attr('maxlength','11');
    $('.switch_to_normal_class').hide();


        
    ajaxGetProductCategories();  
    toastr.options = {
      "closeButton": false,
      "debug": false,
      "newestOnTop": false,
      "progressBar": true,
      "positionClass": "toast-top-right",
      "preventDuplicates": true,
      "onclick": null,
      "showDuration": "300",
      "hideDuration": "500",
      "timeOut": "4000",
      "extendedTimeOut": "500",
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "fadeIn",
      "hideMethod": "fadeOut"
    }



    $('.posgrp_check_date').hide();

    $(document).on("click",".freeze_btn", function(e){
        $('#string_trans_mode').val('frozen');
        freezeTransaction();
    });

    $(document).on("click",".switch_to_normal_class", function(e){
        $(this).hide();
    });

    $(document).on("click",".swipe_card", function(e){
        $('#swipe_await').modal('show');

        // Event handler for scanstart.cardswipe.
        var scanstart = function () {

        };

        // Event handler for scanend.cardswipe.
        var scanend = function () {

        };

        // Event handler for success.cardswipe.  Displays returned data in a dialog
        var success = function (event, data) {

        }

        var failure = function () {
           
        }
        // Bind event listeners to the document
        $(document)
            .on("scanstart.cardswipe", scanstart)
            .on("scanend.cardswipe", scanend)
            .on("success.cardswipe", success)
            .on("failure.cardswipe", failure)
        ;

        
        // Bind event listeners to the document
        

        var row = $(this).closest('.cc_field');
        var cc_num = row.find('.cc_card_number');
        var cc_name = row.find('.cc_card_name');
        var cc_type = row.find('.cc_card_type select');
        var cc_expiry = row.find('.cc_card_expiry');

        var date = new Date();
        // alert(date.getMonth()+1);
        var curr_mm = date.getMonth()+1;
        var curr_yy = date.getFullYear().toString().substr(-2);

        // Called by plugin on a successful scan.
        var complete = function (data) {
            $('#swipe_await').modal('hide');
            // Is it a payment card?
            if (data.type == "generic")
            {
                $('#swipe_error').modal('show');
                return;
            }

            if (parseFloat(data.expYear) < parseFloat(curr_yy)) {
                //alert(parseFloat(parseFloat(data.expYear)+" "+parseFloat(curr_yy)));
                $('#swipe_expired').modal('show');
                return;
            } else if (parseFloat(data.expMonth) <= parseFloat(curr_mm) && parseFloat(data.expYear) <= parseFloat(curr_yy)) {
                // alert(parseFloat(data.expMonth)+" "+parseFloat(curr_mm)+" "+parseFloat(data.expYear)+" "+parseFloat(curr_yy));
                $('#swipe_expired').modal('show');
                return;
            }

            // Copy data fields to form
            // cc_type.val(data.type);
            // $('.cc_card_type option[value='+data.type+']').prop('selected',true);
            row.find('.cc_card_type option[value='+data.type+']').prop('selected',true);
            cc_name.val($.trim(data.firstName)+ ' '+$.trim(data.lastName));
            cc_num.val(data.account);
            cc_expiry.val(data.expMonth+'/'+data.expYear);
            $(document).off(".cardswipe-listener");

            
        };

        $.cardswipe({
            firstLineOnly: true,
            success: complete,
            parsers: ["visa", "amex", "mastercard", "discover", "generic"],
            debug: false
        });


    });
    $(document).on("click",".remove_card", function(e){
        $(this).closest('.cc_field').remove();
        computeBalanceDisplayCardMulti(0);
    });

    $(document).on("click",".remove_check", function(e){
        $(this).closest('.check_field').remove();
        computeBalanceDisplayCheckMulti(0);
    });

    $(document).on("click",".check_is_pdc", function(e){
        var row = $(this).closest('.check_field');
        var opt = row.find('.posgrp_check_date');
        //TO REMOVE CHECK
        //var opt = row.find('#uniform-cform-check_is_pdc > span');
        //opt.removeClass('checked');

        if ($(this).val() == 0) {
            $(this).val(1);
            opt.show();
        } else {
            $(this).val(0);
            opt.hide();
        }

        //alert($(this).val());
        
        
    });


    $('.posgrp_cust_search_marriage_date').hide();
    $('.customer_continue_btn').hide();
    $('.customer_search_again_btn').hide();

    $('.cust_search_marital').on("change", function()
    {
        var opt = $('.cust_search_marital').val();
        if (opt == 'married') {
            $('.posgrp_cust_search_marriage_date').show();
        } else {
            $('.posgrp_cust_search_marriage_date').hide();
            $('#cform-cust_search_marriage_date').val('');
        }
    });

    $(document).on("click",".customer_search_again_btn", function(e){
        clearCustomerFields();
        $('.customer_seach_main_div').show();
        $('.customer_search_btn').show();
        $('.customer_clear_search_btn').show();
        $('.add_customer').show();
        $('.customer_continue_btn').hide();
        $('.customer_search_again_btn').hide();
        $('.save_customer_button').show();
    });

    $(document).on("click",".customer_continue_btn", function(e) {
        swal("Success!", 'Customer selected!',"success");
        $('#customer_modal').modal('hide');
        if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0 && $('#string_trans_mode').val() != 'quotation') {
            $('#final_modal').modal('show');
        } else if ($('#string_trans_mode').val() == 'quotation') {
            $('#final_modal2').modal('show');
        }
    }); 

    $(document).on("click",".cancel_cust_search", function(e){
        resetCustomerModal();
    });

    $(document).on("click",".view_customer_btn", function(e){
        clearCustomerFields();
        $('.save_customer_button').hide();
        $('.customer_continue_btn').show();
        // $('.customer_search_again_btn').show();

        var row = $(this).closest('tr');
        var opt = row.find('.marital_status').val();
        if (opt == 'married') {
            $('.posgrp_cust_search_marriage_date').show();
        } else {
            $('.posgrp_cust_search_marriage_date').hide();
            $('#cform-cust_search_marriage_date').val('');
        }

        $('#transaction_customer_id').val(row.find('.id').val());

        $('#cform-cust_search_id').val(row.find('.id').val());
        $('#cform-cust_search_firstname').val(row.find('.first_name').val());
        $('#cform-cust_search_middle_name').val(row.find('.middle_name').val());
        $('#cform-cust_search_lastname').val(row.find('.last_name').val());
        $('#cform-cust_search_home_phone').val(row.find('.home_phone').val());
        $('#cform-cust_search_mobile').val(row.find('.number').val());
        $('#cform-cust_search_email').val(row.find('.email').val());
        $('#cform-cust_search_birthdate').val(row.find('.birthdate').val());
        $('#cform-cust_search_address_1').val(row.find('.address1').val());
        $('#cform-cust_search_address_2').val(row.find('.address2').val());
        $('#cform-cust_search_city').val(row.find('.city').val());
        $('#cform-cust_search_state').val(row.find('.state').val());
        $('#cform-cust_search_country').val(row.find('.country').val());
        $('#cform-cust_search_zip').val(row.find('.zip').val());
        $('#cform-cust_search_marriage_date').val(row.find('.date_married').val());
        $('#cform-cust_search_notes').val(row.find('.notes').val());
        $('.cust_search_marital').val(row.find('.marital_status').val());
        $('#uniform-cform-cust_search_gender > span').each(function() {
            if ($(this).find('#cform-cust_search_gender').val() == row.find('.gender').val()) {
                $(this).addClass('checked');
            }
        });

        var objDiv = document.getElementById("cust_formx");
        objDiv.scrollTop = 0;

    });

    $(document).on("click",".use_customer_btn", function(e){
        var row = $(this).closest('tr');
        var balance = $('#float_trans_balance').val();
        $('#transaction_customer_id').val(row.find('.id').val());

        var raw_disp_id = row.find('.display_id').val();
        var foo = raw_disp_id.split(" ").join("");
        if (foo.length > 0) {
            foo = foo.match(new RegExp('.{1,3}', 'g')).join(" ");
        }

        $('#transaction_customer_display_id').val(foo);
        $('#transaction_customer_name').val(row.find('.last_name').val()+", "+row.find('.first_name').val());
        $('#customer_modal').modal('hide');
        swal("Success!", 'Customer selected!',"success");
        if ($('#string_trans_type').val() != 'none' && balance <= 0) {
            if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0 && $('#string_trans_mode').val() != 'quotation') {
                $('#final_modal').modal('show');
            } else if ($('#string_trans_mode').val() == 'quotation') {
                $('#final_modal2').modal('show');
            } else if ($('#string_trans_mode').val() == 'Deposit') {
                $('#final_modal2').modal('show');
            }
        }

        if ($('#string_trans_mode').val() == 'Deposit') {
            $('#final_modal2').modal('show');
        }
        

    });


    $(document).on("click",".customer_clear_search_btn", function(e){
        clearCustomerFields();
        $('.save_customer_button').show();
        $('.customer_continue_btn').hide();
        $('.f_required').each(function() {
            $(this).parent().parent().removeClass('has-error_pos');
        });

        $('.f_required_select').each(function() {
            $(this).parent().parent().removeClass('has-error_pos');
        });

        $('#cform-cust_search_birthdate').parent().parent().removeClass('has-error_pos');

    });

    // CC



    /* Fancy restrictive input formatting via jQuery.payment library*/
    $('input[name=cc_card_number]').payment('formatCardNumber');
    $('input[name=cc_card_cvv]').payment('formatCardCVC');
    $('input[name=cc_card_expiry').payment('formatCardExpiry');

    /* Form validation using Stripe client-side validation helpers */
    jQuery.validator.addMethod("cc_card_number", function(value, element) {
        return this.optional(element) || Stripe.card.validateCardNumber(value);
    }, "Please specify a valid credit card number.");

    jQuery.validator.addMethod("cc_card_expiry", function(value, element) {    
        /* Parsing month/year uses jQuery.payment library */
        value = $.payment.cardExpiryVal(value);
        return this.optional(element) || Stripe.card.validateExpiry(value.month, value.year);
    }, "Invalid expiration date.");

    jQuery.validator.addMethod("cc_card_cvv", function(value, element) {
        return this.optional(element) || Stripe.card.validateCVC(value);
    }, "Invalid CVC.");


    // END CC



    // CLEAN
    $('.updated_totals_row').hide();
    $('.deposit_amount_totals_row').hide();
    $('.balance_totals_row').hide();

    $(document).on("click",".false_remove_row", function(e){
        sweetAlert("Can't remove item!", "Item already issued", "error");
    });

    $(document).on("click",".remove_row", function(e){
        var trans_type = $('#string_trans_type').val();
        var trans_mode = $('#string_trans_mode').val();
        var trans_amt = $('#float_trans_amount').val();
        var balance = $('#float_trans_balance').val();

        if (balance < trans_amt) {
            if (trans_mode == 'Deposit') {
                e.preventDefault();            
                var tr = $(this).closest('tr');
                tr.remove();

                var rowCount = $('#cart_table tr').length-1;
                $('.cart_items_count').text(rowCount.toString());

                if (rowCount == 0) {
                    var field = '<tr class=\"init_row_prods\">';     
                    field += '<td colspan=\"3\" class=\"xrow\"><p>No items added</p></td>';
                    field += '</tr>';

                    $('#cart_items').prepend(field);
                }

                if($('#string_trans_type').val() == 'none' || $('#string_trans_type').val() == 'reg') {
                    computeCartRaw();
                } else if($('#string_trans_type').val() == 'per') {
                    // alert('remove indiv');
                    computeCartRaw();
                    computeCartIndiv();
                } else if($('#string_trans_type').val() == 'bulk') {
                    computeCartRaw();
                    applyBulkAdjustment();
                } else {
                    computeCartRaw();
                }
                computeBalance();    
            } else {
                sweetAlert("Can't remove item!", "Payment already made", "error");
            }
        } else {
            if (trans_type == 'bulk') {
                sweetAlert("Can't remove item!", "Reset transaction type to remove item/s", "error");
            } else {
                e.preventDefault();            
                var tr = $(this).closest('tr');
                tr.remove();

                //count number of products in cart
                var rowCount = $('#cart_table tr').length-1;
                $('.cart_items_count').text(rowCount.toString());

                if (rowCount == 0) {
                    var field = '<tr class=\"init_row_prods\">';     
                    field += '<td colspan=\"3\" class=\"xrow\"><p>No items added</p></td>';
                    field += '</tr>';

                    $('#cart_items').prepend(field);
                }

                if($('#string_trans_type').val() == 'none' || $('#string_trans_type').val() == 'reg') {
                    computeCartRaw();
                } else if($('#string_trans_type').val() == 'per') {
                    // alert('remove indiv');
                    computeCartRaw();
                    computeCartIndiv();
                } else if($('#string_trans_type').val() == 'bulk') {
                    computeCartRaw();
                    applyBulkAdjustment();
                } else {
                    computeCartRaw();
                }
                computeBalance();    
            }
        }

        return false;
    });

    $(document).on("click",".cp_customers", function(e){
        $('#customer_modal').modal('show');
    });

    $('#cform-cust_search_id').on('input',function(e){
            var foo = $(this).val().split(" ").join("");
          if (foo.length > 0) {
            foo = foo.match(new RegExp('.{1,3}', 'g')).join(" ");
          }
          $(this).val(foo);
    });

    $('#cform-cust_search_id').keyup(function() {
      var foo = $(this).val().split(" ").join("");
      if (foo.length > 0) {
        foo = foo.match(new RegExp('.{1,3}', 'g')).join(" ");
      }
      $(this).val(foo);
    });

    $(document).on("click",".customer_search_btn", function(e){
        // clearCustomerFields();
        $('.f_required').each(function() {
            $(this).parent().parent().removeClass('has-error_pos');
        });

        $('.f_required_select').each(function() {
            $(this).parent().parent().removeClass('has-error_pos');
        });

        $('#cform-cust_search_birthdate').parent().parent().removeClass('has-error_pos');

        var first_name = "%20"; if($('#cform-cust_search_firstname').val() != ''){first_name = $('#cform-cust_search_firstname').val()};
        var middle_name = "%20"; if($('#cform-cust_search_middle_name').val() != ''){middle_name = $('#cform-cust_search_middle_name').val()};
        var last_name = "%20"; if($('#cform-cust_search_lastname').val() != ''){last_name = $('#cform-cust_search_lastname').val()};//$('#cform-cust_search_lastname').val();
        var email = "%20"; if($('#cform-cust_search_email').val() != ''){email = $('#cform-cust_search_email').val()};//$('#cform-cust_search_email').val();
        var number = "%20"; if($('#cform-cust_search_mobile').val() != ''){number = $('#cform-cust_search_mobile').val()};//$('#cform-cust_search_mobile').val();

        var customer_id = "%20"; if($('#cform-cust_search_id').val() != ''){customer_id = $('#cform-cust_search_id').val()};
        var gender = "%20"; if($("input[name='cust_search_gender']").is(":checked")){gender = $("input[name='cust_search_gender']:checked").val()} ;
        var marital_status = "%20"; if($('.cust_search_marital').val() != '' && $('.cust_search_marital').val() != 'undefined'){marital_status = $('.cust_search_marital').val()};
        var date_married = "%20"; if($('#cform-cust_search_marriage_date').val() != ''){date_married = $('#cform-cust_search_marriage_date').val()};
        var home_phone = "%20"; if($('#cform-cust_search_home_phone').val() != ''){home_phone = $('#cform-cust_search_home_phone').val()};
        var birthday = "%20"; if($('#cform-cust_search_birthdate').val() != ''){birthday = $('#cform-cust_search_birthdate').val()};
        var address1 = "%20"; if($('#cform-cust_search_address_1').val() != ''){address1 = $('#cform-cust_search_address_1').val()};
        var address2 = "%20"; if($('#cform-cust_search_address_2').val() != ''){address2 = $('#cform-cust_search_address_2').val()};

        var city = "%20"; if($('#cform-cust_search_city').val() != ''){city = $('#cform-cust_search_city').val()};
        var state = "%20"; if($('#cform-cust_search_state').val() != ''){state = $('#cform-cust_search_state').val()};
        var country = "%20"; if($('#cform-cust_search_country').val() != ''){country = $('#cform-cust_search_country').val()};
        var zip = "%20"; if($('#cform-cust_search_zip').val() != ''){zip = $('#cform-cust_search_address_2').val()};


        if (first_name == '%20' && middle_name == '%20' && last_name == '%20' && email == '%20' && number == '%20' && gender == '%20' && marital_status == '%20' && date_married == '%20' && home_phone == '%20' && birthday == '%20' && address1 == '%20' && address2 == '%20' && city == '%20' && state == '%20' && country == '%20' && zip == '%20' && customer_id != '%20') {
            if (customer_id.length < 7) {
                swal('','You must enter atleast 7 digits to search by customer ID','error');
            }
            else {
                ajaxSearchCustomer();
            }
        } else {
            ajaxSearchCustomer();
        }
    });

    $(document).on("click",".save_customer_button", function(e){
        var complete_flag = true;
        $('.f_required').each(function() {
            if ($(this).val() == '') {
                
                complete_flag = false;
            }
        });

        $('.f_required_select').each(function() {

            if ($(this).val() == '') {
                
                complete_flag = false;
            }
        });

        if ($('.f_required_gender').length > 0) {
            if($('.f_required_gender:checked').length <= 0){
                complete_flag = false;
             }
        }

        $('.f_required_date').each(function() {
            if ($(this).val() == '') {
                
                complete_flag = false;
            }
        });

        if (complete_flag) {
            ajaxAddCustomer();
        } else {
            swal("Missing fields!", "Please complete form with (*)", "error"); 
           // .parent().parent().addClass('has-error')
            $('.f_required').each(function() {
                if ($(this).val() == '') {
                    $(this).parent().parent().addClass('has-error_pos');
                } else {
                    $(this).parent().parent().removeClass('has-error_pos');
                }
            });

            $('.f_required_select').each(function() {
                if ($(this).val() == '') {
                    $(this).parent().parent().addClass('has-error_pos');
                } else {
                    $(this).parent().parent().removeClass('has-error_pos');
                }   
            });

            $('.f_required_date').each(function() {
                if ($(this).val() == '') {
                    $(this).parent().parent().addClass('has-error_pos');
                } else {
                    $(this).parent().parent().removeClass('has-error_pos');
                }
            });

        }
        
    });

    $(document).on("click",".add_customer", function(e){
        $('#customer_modal').modal('hide');
        $('#add_customer_modal').modal('show');
    });

    $(document).on("click",".cp_quotation", function(e){
        var trans_amt = $('#float_trans_amount').val();
        var balance = $('#float_trans_balance').val();

        if (balance < trans_amt && trans_amt > 0) {
            swal("Cannot change to quotation!", "Payment already made", "error");
        } else if ($('#string_trans_mode').val() == 'Deposit') {
            swal("Cannot change to quotation!", "Deposit mode active", "error");
        } else {
            if ($('#string_trans_mode').val() == 'normal') {
                $('#quotation_modal').modal('show');
            } else {
                $('#rev_quotation_modal').modal('show');
            }
        }   
    });

    $(document).on("click",".cp_freeze", function(e){
        var trans_amt = $('#float_trans_amount').val();
        var balance = $('#float_trans_balance').val();

        if (balance == 0 && trans_amt > 0) {
            swal("Cannot freeze transaction!", "Full payment already made", "error");
        } else if ($('#string_trans_mode').val() == 'Deposit') {
            swal("Cannot freeze transaction!", "Deposit mode active", "error");
        } else {
            //loadFrozenTransactions();
            $('#freeze_modal').modal('show');
        }
    });

    
    

    


    $(document).on("click",".next_step_btn", function(e){
        if ($('#cart_table tr').length > 1 && $('#cart_table .xrow').length == 0) {
            $('#transaction_type_modal').modal('show');
        } else {
            toastr['warning']('Add products to cart before proceeding to next step.', 'Warning');
        }
    });



    $(document).on("click",".clear_discount", function(e){
        revertDiscounts();
        $('.customer_savings').text("0.00");
        $('.savings_h4').hide();
    });

    $('#cform-indiv_adj').on("change", function()
    {
        var indiv_adj_opt = $('#cform-indiv_adj').val();
        if (indiv_adj_opt == 'chg') {
            $('#cform-new_price').val('');
            $('#cgroup-new_price').show();
        } else {
            $('#cgroup-new_price').hide();
            $('#cform-new_price').val('');
        }
    });

    // $("#cform-discount_pct").keyup(function() {
    //     $("#cform-discount_pct").val(this.value.match(/[0-9]*/));
    // });

    $(document).on('keydown', '#cform-discount_pct', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });



    // $("#cform-discount_amount").keyup(function() {
    //     $("#cform-discount_amount").val(this.value.match(/[0-9]*/));
    // });

    $(document).on('keydown', '#cform-discount_amount', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

    $(".cc_card_expiry").focusout(function() {
        var date = new Date();
        var this_eleme = $(this);
        // alert($(this).val().length);
        // alert(date.getMonth()+1);
        var curr_mm = date.getMonth()+1;
        var curr_yy = date.getFullYear().toString().substr(-2);
        if ($(this).val().length == 7) {
            var mm = $(this).val().substring(0, 2);
            var yy = $(this).val().substring(5, 7);
            // alert(mm+'/'+yy);
            if (mm != '' && yy != '')
            {
                if (parseFloat(yy) < parseFloat(curr_yy)) {
                    //$('#swipe_expired').modal('show');
                    swal({
                      title: "Card expired!",
                      text: "",
                      type: "error",
                      showCancelButton: true,
                      showConfirmButton: true,
                      confirmButtonText: "Edit card details",
                      cancelButtonText: "Go back to payment options",
                    },
                    function(isConfirm){
                        if (isConfirm) {

                        } else {
                            clearCreditCardModal();
                            $('#cc_modal').modal('hide');
                            $('#swipe_expired').modal('hide');
                            $('#checkout_modal').modal('show');
                            computeBalanceDisplayCardMulti(0);
                        }   
                    });
                    
                    // alert(mm+'/'+yy);
                    
                } else if (parseFloat(mm) <= parseFloat(curr_mm) && parseFloat(yy) <= parseFloat(curr_yy)) {
                    swal({
                      title: "Card expired!",
                      text: "",
                      type: "error",
                      showCancelButton: true,
                      showConfirmButton: true,
                      confirmButtonText: "Edit card details",
                      cancelButtonText: "Go back to payment options",
                    },
                    function(isConfirm){
                        if (isConfirm) {

                        } else {
                            clearCreditCardModal();
                            $('#cc_modal').modal('hide');
                            $('#swipe_expired').modal('hide');
                            $('#checkout_modal').modal('show');
                            computeBalanceDisplayCardMulti(0);
                        }   
                    });
                }
            } 
            else 
            {
                swal('Invalid expirty date','Please enter expiry date again', 'error');
                $(this).val('');
            }
        }
    });

    $(document).on('keydown', '#cform-new_price', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

    $(document).on("click",".bulk_adj", function(e){
        $('#bulk_adjustment').modal('show');
    });

    $(document).on('keydown', '.per_item_discount_amt', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

    $('#customer_modal').on('hidden.bs.modal', function () {

        $('.f_required').each(function() {
            $(this).parent().parent().removeClass('has-error_pos');
        });

        $('.f_required_select').each(function() {
            $(this).parent().parent().removeClass('has-error_pos');
        });
        $('.save_customer_button').show();
        $('.customer_continue_btn').hide();
        $('#cform-cust_search_birthdate').parent().parent().removeClass('has-error_pos');
    });

    $('#customer_modal').on('hidden.bs.modal', function () {
        resetCustomerModal();
    });

    $('#checkout_modal').on('shown.bs.modal', function () {
        if ($('#string_trans_mode').val() == 'quotation') {
            $('.switch_to_normal_class').show();
        } else {
            $('.switch_to_normal_class').hide();
        }
    });

    $(document).on('keyup', '.per_item_discount_amt', function () {
        var row = $(this).closest('tr');
        var srp = row.find('.srp').val();
        var input_amt = $(this).val();
        var adjusted_price = row.find('.adjusted_price');
        var per_item_discount_amt = row.find('.per_item_discount_amt');
        var pos_indiv_discount_opt = row.find('.pos_indiv_discount_opt').val();

        if (pos_indiv_discount_opt == 'disc') {
            if (parseFloat(input_amt) > 100) {
                toastr['error']('Discount percentage exceeded.', 'Error');
                $(this).val(100);
            }
            var discounted_price = srp - (srp * (input_amt/100));
            adjusted_price.val(discounted_price);
        } else if (pos_indiv_discount_opt == 'discamt') {
            if (input_amt < 0 || input_amt == '') {
                var discounted_price = parseFloat(srp);
                adjusted_price.val(discounted_price);
            } else {
                var discounted_price = parseFloat(srp) - parseFloat(input_amt);
                adjusted_price.val(discounted_price);
            }
        } else if (pos_indiv_discount_opt == 'chg') {
            adjusted_price.val(input_amt);
        }
        
        computeCartIndiv();
        computeCartMinimum();
        computeBalance();

    });

    $(document).on("click",".proceed_deposit", function(e){
        if ($('#transaction_customer_id').val() == 0) {
            $('#customer_modal').modal('show');
        } else {
            if ($('#transaction_reference_sys_id').val() != '0') {
                swal({
                  title: "Customer already selected!",
                  text: "Name: "+$('#transaction_customer_name').val()+" ID: "+$('#transaction_customer_display_id').val(),
                  type: "success",
                  showConfirmButton: true,
                  confirmButtonText: "Proceed",
                },
                function(isConfirm){
                    if (isConfirm) {
                       if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0 && $('#string_trans_mode').val() != 'quotation') {
                            $('#final_modal').modal('show');
                        } else if ($('#string_trans_mode').val() == 'quotation') {
                            $('#final_modal2').modal('show');
                        } else {
                            $('#final_modal2').modal('show');
                        }
                    }
                });
            } else {
                swal({
                  title: "Customer already selected!",
                  text: "Name: "+$('#transaction_customer_name').val()+" ID: "+$('#transaction_customer_display_id').val(),
                  type: "success",
                  showCancelButton: true,
                  showConfirmButton: true,
                  confirmButtonText: "Proceed",
                  cancelButtonText: "Change customer",
                },
                function(isConfirm){
                    if (isConfirm) {
                       if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0 && $('#string_trans_mode').val() != 'quotation') {
                            $('#final_modal').modal('show');
                        } else if ($('#string_trans_mode').val() == 'quotation') {
                            $('#final_modal2').modal('show');
                        } else {
                            $('#final_modal2').modal('show');
                        }
                    } else {
                        $('#customer_modal').modal('show');
                    }   
                });
            }
        }
    });



    $(document).on("click",".finish_btn", function(e){
        var balance = $('#float_trans_balance').val();
        var payment_total = 0;
        $('.payment_amt_float').each(function() {
            payment_total += parseFloat($(this).val());
        });

        if (balance <= 0) {
            swal("Payment Complete!", "Enter customer information on the next form", "success");
            if ($('#string_trans_mode').val() == 'Deposit') {
                $('#string_trans_mode').val('normal');
            }
            
            $('#checkout_modal').modal('hide');
            if ($('#transaction_customer_id').val() == 0) {
                $('#customer_modal').modal('show');
            } else {
                if ($('#transaction_reference_sys_id').val() != '0') {
                    swal({
                      title: "Customer already selected!",
                      text: "Name: "+$('#transaction_customer_name').val()+" ID: "+$('#transaction_customer_display_id').val(),
                      type: "success",
                      showConfirmButton: true,
                      confirmButtonText: "Proceed",
                    },
                    function(isConfirm){
                        if (isConfirm) {
                           if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0 && $('#string_trans_mode').val() != 'quotation') {
                                $('#final_modal').modal('show');
                            } else if ($('#string_trans_mode').val() == 'quotation') {
                                $('#final_modal2').modal('show');
                            } else {
                                $('#final_modal2').modal('show');
                            }
                        }
                    });
                } else {
                    swal({
                          title: "Customer already selected!",
                          text: "Name: "+$('#transaction_customer_name').val()+" ID: "+$('#transaction_customer_display_id').val(),
                          type: "success",
                          showCancelButton: true,
                          showConfirmButton: true,
                          confirmButtonText: "Proceed",
                          cancelButtonText: "Change customer",
                        },
                        function(isConfirm){
                            if (isConfirm) {
                               if ($('#string_trans_type').val() != 'none' && parseFloat($('#float_trans_balance').val()) <= 0 && $('#string_trans_mode').val() != 'quotation') {
                                    $('#final_modal').modal('show');
                                } else if ($('#string_trans_mode').val() == 'quotation') {
                                    $('#final_modal2').modal('show');
                                } else {
                                    $('#final_modal2').modal('show');
                                }
                            } else {
                                $('#customer_modal').modal('show');
                            }   
                        });
                }
            }
            
        } else {
            if ($('#string_trans_mode').val() == "quotation" || payment_total == 0) {
                swal({
                      title: "Payment incomplete!",
                      text: "Balance of "+addCommas(parseFloat(balance))+" not paid",
                      type: "error",
                      showConfirmButton: true,
                      confirmButtonText: "Go back to payment options"
                    });
            } else {
                swal({
                      title: "Payment incomplete!",
                      text: "Balance of "+addCommas(parseFloat(balance))+" not paid",
                      type: "error",
                      showCancelButton: true,
                      showConfirmButton: true,
                      confirmButtonText: "Deposit Mode",
                      cancelButtonText: "Go back to payment options",
                    },
                    function(isConfirm){
                        if (isConfirm) {
                            // 1 add two rows on vats table
                            // 2 add checkboxes on cart items

                            // 1
                            $('.deposit_amount_totals_row').show();
                            $('.balance_totals_row').show();

                            // 2
                            appendDepositItemColumns();
                            appendDepositItemFields();
                            computeVATDeposit(payment_total);
                            computeVATBalance(parseFloat(balance));
                            $('#float_trans_deposit_amount').val(payment_total);
                            $('#string_trans_mode').val('Deposit');
                            $('.proceed_deposit').show();
                            $('#checkout_modal').modal('hide');
                            swal.close();

                        } else {
                            
                        }   
                    });
            }
            //}
        }
    });

    $(document).on("click",".apply_bulk", function(e){
        applyBulkAdjustment();
    });

    $(document).on("click",".view_cart_btn", function(e){
        $('#cart_a').click();
    });

    $(document).on("click",".category_btn", function(e){

        $('.category_btn').each(function() {
            $(this).css({'background-color': '#556E93'});
        });
        $('#products_a').click();
        $('#selected_pcat').text(' - '+$(this).html());
        $(this).css({'background-color': '#484c50'});
    });

    $(document).on('keydown', '#cform-cash_received_amt', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

    $(document).on('keydown', '.cc_charge_amt', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

    $(document).on('keydown', '.check_amount', function (event) {
        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 110) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && (event.keyCode == 190 || event.keyCode == 110))
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

    $(document).on('keyup', '.cc_charge_amt', function (event) {
        computeBalanceDisplayCardMulti();
    });

    $(document).on('keyup', '.check_amount', function (event) {
        computeBalanceDisplayCheckMulti();
    });

    $(document).on('keyup', '#cform-cash_received_amt', function () {
        // $(this).val(this.value.match(/[0-9]*/));
        if ($(this).val() != '') {
            var amt_to_pay = $('#float_trans_balance').val();
            var chg_amt = parseFloat($(this).val()) - parseFloat(amt_to_pay);
            if (chg_amt >= 0) {
                var change = chg_amt;  
                $('#cash_chg_amt').text(addCommas(change));  
            } else {
                var change = '0.00';
                $('#cash_chg_amt').text(change);
            }

            computeBalanceDisplay($(this).val());
            
        } else {
            $('#cash_chg_amt').text("0.00");
            computeBalanceDisplay(0);
        }
        

    });

    $(document).on("click",".numeric_key", function(e){
        if ($(this).data("value") == 'CLEAR') {
            $('#cform-cash_received_amt').val("");
            $('#cash_chg_amt').text(0.00);
        } else if ($(this).data("value") == 'DEL') {
            var str = $('#cform-cash_received_amt').val();
            $('#cform-cash_received_amt').val(str.substring(0, str.length - 1));
            var amt_to_pay = $('#float_trans_balance').val();
            var chg_amt = parseFloat($('#cform-cash_received_amt').val()) - amt_to_pay;
            if (chg_amt >= 0) {
                var change = chg_amt;  
                $('#cash_chg_amt').text(addCommas(change));  
            } else {
                var change = '0.00';
                $('#cash_chg_amt').text(change);
            }
            $('#cash_chg_amt').text(addCommas(change));
        } else {
            if($('#cform-cash_received_amt').val().indexOf('.') !== -1 && ($(this).data("value") == '.')) {
                e.preventDefault();
            } else {
                $('#cform-cash_received_amt')[0].value += $(this).data("value");
                var amt_to_pay = $('#float_trans_balance').val();
                var chg_amt = parseFloat($('#cform-cash_received_amt').val()) - amt_to_pay;
                if (chg_amt >= 0) {
                    var change = chg_amt;  
                    $('#cash_chg_amt').text(addCommas(change));  
                } else {
                    var change = '0.00';
                    $('#cash_chg_amt').text(change);
                }
            }
        }

        computeBalanceDisplay($('#cform-cash_received_amt').val());
    });

    

    $(window).keydown(function(event){
        if(event.keyCode == 13) {
          event.preventDefault();
          return false;
        }
    });


    $(document).on("click",".cash_proceed_btn", function(e){
        var payment_amt = $('#cform-cash_received_amt').val();
        if (payment_amt > 0) {
            addToPayments('Cash', parseFloat(payment_amt));
            $('#cash_modal').modal('hide');
            $('#cform-cash_received_amt').val('');
            $('#checkout_modal').modal('show');
        } else {
            toastr['error']('Invalid payment amount.', 'Error');
        }
        
    });

    $(document).on("click",".card_proceed_btn", function(e){
        var complete_flag = true;

        $('#cc_form').find('.cc_field').each(function() {
            var cc_number = $(this).find('#cform-cc_card_number').val();
            var cc_name = $(this).find('#cform-cc_card_name').val();
            var payment_amt = $(this).find('#cform-cc_charge_amt').val(); 
            var cc_bank = $(this).find('#cform-cc_bank').val(); 
            var cc_expiry = $(this).find('#cform-cc_card_expiry').val(); 
            if (cc_number != '' && payment_amt != '' && cc_name != '' && cc_expiry != '') {
               if (complete_flag) {
                    complete_flag = true;
                }
            } else {
                complete_flag = false;
            }
        });

        if (complete_flag) {
            $('#cc_form').find('.cc_field').each(function() {
                var cc_number = $(this).find('#cform-cc_card_number').val();
                var cc_name = $(this).find('#cform-cc_card_name').val();
                var payment_amt = $(this).find('#cform-cc_charge_amt').val(); 
                var cc_bank = $(this).find('#form-cc_bank option:selected').text(); 
                var cc_expiry = $(this).find('#cform-cc_card_expiry').val().replace(/\//g, '-');; 
                var cc_name = $(this).find('#cform-cc_card_name').val(); 

                var cc_type = $(this).find('#cform-form-cc_card_type option:selected').text();
                var cc_cvv = $(this).find('#cform-cc_card_cvv').val(); 

                var cc_terminal_opt = $(this).find('#cform-cc_terminal_operator option:selected').text();
                var cc_interest = $(this).find('#form-interest_indiv option:selected').text();
                var cc_terms = $(this).find('#form-cc_terms option:selected').text();
                var cc_details = cc_number + "," + cc_name + "," + cc_bank;

                addToPayments('Credit Card', parseFloat(payment_amt), null, cc_number, cc_bank, cc_terminal_opt, cc_interest, cc_terms, null, null, cc_name, cc_expiry, cc_cvv);
                clearCreditCardModal();
            });

            $('#cc_modal').modal('hide');
            $('#checkout_modal').modal('show');
        } else {
            swal('Incomplete fields!','Please enter card details to continue','error');
        }   
    });

    $(document).on("click",".card_w_interest", function(e){
        var atLeastOneIsChecked = $('.card_w_interest:checkbox:checked').length > 0;

        if (atLeastOneIsChecked) {
            $('#string_trans_cc_interest').val('true');
        } else {
            $('#string_trans_cc_interest').val('false');
        }
    }); 

    $(document).on("click",".check_proceed_btn", function(e){
        var complete_flag = true;

        $('#check_form').find('.check_field').each(function() {
            var check_number = $(this).find('#cform-check_number').val();
            var payment_amt = $(this).find('#cform-check_amount').val(); 
            if (check_number != '' && payment_amt != '') {
                if (complete_flag) {
                    complete_flag = true;
                }
            } else {
                complete_flag = false;
            }
        });

        if (complete_flag) {
            $('#check_form').find('.check_field').each(function() {
                var check_number = $(this).find('#cform-check_number').val();
                var account_number = $(this).find('#cform-check_account_number').val();
                var payment_amt = $(this).find('#cform-check_amount').val(); 
                var bank = $(this).find('#form-check_bank option:selected').text(); 
                var payee = $(this).find('#cform-check_payee_name').val(); 
                var payor = $(this).find('#cform-check_payor_name').val(); 

                addToPayments('Check', parseFloat(payment_amt), null, check_number, bank, null, null, null, account_number, payee, payor, null, null);
                clearCheckModal();
            });

            $('#check_modal').modal('hide');
            $('#checkout_modal').modal('show');
        } else {
            swal('Incomplete fields!','Please enter check details to continue','error');
        }
    });

    $(document).on("click",".remove_customer", function(e){
        e.preventDefault();            
        var tr = $(this).closest('tr');
        tr.remove();
        return false;

    });

    $(document).on("click",".remove_payment_row", function(e){
        e.preventDefault();            
        var tr = $(this).closest('tr');
        tr.remove();

        //count number of payments in list
        var rowCount = $('#payments_table tr').length-1;

        if (rowCount == 0) {
            var field = '<tr class=\"init_row_payment\">';     
            field += '<td colspan=\"3\"><p>No payments added</p></td>';
            field += '</tr>';

            $('#payments_table').prepend(field);
        }

        computeBalance();
        toastr['success']('Payment removed', 'Success');
        return false;
    });

    $(document).on("click",".add_card_btn", function(e){
        // var row_id = Math.round(new Date().getTime() + (Math.random() * 100));
        // alert(row_id);
        $("#cc_fields").children().clone(true,true).find("input").val("").end().appendTo('#cc_form');
        $('input[name=cc_card_number]').payment('formatCardNumber');
        $('input[name=cc_card_cvv]').payment('formatCardCVC');
        $('input[name=cc_card_expiry').payment('formatCardExpiry');

        var objDiv = document.getElementById("cc_form");
        objDiv.scrollTop = objDiv.scrollHeight;

        return false;
    });

    $(document).on("click",".add_check_btn", function(e){
        $("#check_fields").children().clone(true,true).find("input").val("").end().appendTo('#check_form');
        var objDiv = document.getElementById("check_form");
        objDiv.scrollTop = objDiv.scrollHeight;
        return false;
    });

    $(document).on("click",".checkout_btn", function(e){
        if ($('#cart_table tr').length > 1) {
            $('#checkout_modal').modal('show');
            var rowCount = $('#payments_table tr').length-1;
            if (parseFloat($('#float_trans_balance').val()) == 0 && rowCount == 0) {
                $('.co_amt_to_pay').text($('#transaction_amt_to_pay').val());
                $('.co_balance').text($('#transaction_amt_to_pay').val());
            } else {
                $('.co_amt_to_pay').text($('#transaction_amt_to_pay').val());
            }
        } else {
            toastr['warning']('Add products to cart before proceeding to next step.', 'Warning');
        }
        
    });


    $('.bulk_adj').hide();
    $('.clear_discount').hide();
    $('.checkout_btn').hide();
    $('.proceed_deposit').hide();
    $('.orig_totals_row').hide();
    $('.orig_price_h3').hide();
    $('.bulk_discount_h4').hide();
    $('.savings_h4').hide();
    

    $('#cform-new_price').val('');
    $('#cgroup-new_price').hide();
    hideBulkAmounts();





    $(document).on("click",".co_cash_payment", function(e){
        $('#checkout_modal').modal('hide');
        $('#cash_modal').modal('show');
    });

    $(document).on("click",".co_cc_payment", function(e){
        $('#checkout_modal').modal('hide');
        $('#cc_modal').modal('show');
    });

    $(document).on("click",".co_check_payment", function(e){
        $('#checkout_modal').modal('hide');
        $('#check_modal').modal('show');
    });

    
    $(document).on("click",".cash_go_back", function(e){
        $('#cform-cash_received_amt').val('');
        $('#cash_modal').modal('hide');
        $('#checkout_modal').modal('show');
        computeBalanceDisplay(0);
    });

    $(document).on("click",".cc_go_back", function(e){
        clearCreditCardModal();
        $('#cc_modal').modal('hide');
        $('#checkout_modal').modal('show');
        computeBalanceDisplayCardMulti(0);
    });

    $(document).on("click",".cc_go_back2", function(e){
        clearCreditCardModal();
        $('#cc_modal').modal('hide');
        $('#swipe_expired').modal('hide');
        $('#checkout_modal').modal('show');
        computeBalanceDisplayCardMulti(0);
    });

    $(document).on("click",".check_go_back", function(e){
        clearCheckModal();
        $('#check_modal').modal('hide');
        $('#checkout_modal').modal('show');
        computeBalanceDisplayCheckMulti(0);
    });



    //Proceed
    $(document).on("click",".proceed_btn", function(e){
        proceedToTransaction();
    });
});