function computeBalance()
{
    //sum payments first then subtract to transaction amount
    var payments = 0;
    var transaction_amount = parseFloat($('#float_trans_amount').val());
    var transaction_static_amount = parseFloat($('#float_static_trans_amount').val());
    var balance = 0;
    $('.payment_amt_float').each(function(){
        payments = payments + parseFloat($(this).val());
    });

    // less selected items for refund/exchange
    var refund_amt = parseFloat($('#float_trans_refund_amount').val());

    if ($('#flag_refund').val() == "true") {
        balance = ((transaction_static_amount - payments) - refund_amt) + transaction_amount;

        // var bulk_option = $('#bulk_opt_sel').val();
        // var bulk_amt = $('#bulk_opt_amt').val();
        // if (bulk_option != 'none') {
        //     if (bulk_option != 'bgift') {
        //         console.log('BAL BEFORE: '+balance);
        //         console.log('BULK AMT: '+bulk_amt);
        //         balance = balance + parseFloat(bulk_amt);
        //     } else {
        //         balance = 0;
        //     }
        // }
    } else {
        balance = transaction_amount - payments;
    }

    $('#float_trans_balance').val(balance);
    $('.co_balance').text(addCommas(balance));
    $('.co_balance_static').text(addCommas(balance));
    $('.co_balance_disp').text(addCommas(balance));

    computeVATBalance(balance);

    if ($('#flag_refund').val() == "true") {
        computeRefundTotal();
    }
}

function computeBalanceDisplay(amt)
{

    var payments = amt;
    var transaction_amount = $('#float_trans_balance').val();
    var balance = 0;

    balance = transaction_amount - payments;
    $('.co_balance_disp').text(addCommas(balance));

}

function computeBalanceDisplayCardMulti()
{
    var payments = 0;
    var transaction_amount = $('#float_trans_balance').val();
    var balance = 0;

    $('.cc_field').each(function() {
        // alert('payments: '+payments);
        var payment_amt = parseFloat($(this).find('#cform-cc_charge_amt').val());
        // alert('payment amt: '+payment_amt);
        if (payment_amt != '') {
            if (payment_amt > 0) {
                payments = parseFloat(payments) + parseFloat(payment_amt);
            }
        } else {

        }
    });

    balance = parseFloat(transaction_amount) - parseFloat(payments);
    // alert('payments: '+payments+' balance: '+balance);
    $('.co_balance_disp').text(addCommas(balance));
}

function computeBalanceDisplayCheckMulti()
{
    var payments = 0;
    var transaction_amount = $('#float_trans_balance').val();
    var balance = 0;

    $('.check_field').each(function() {
        var payment_amt = $(this).find('#cform-check_amount').val();
        if (payment_amt != '') {
            if (payment_amt > 0) {
                payments = parseFloat(payments) + parseFloat(payment_amt);
            } else {

            }
        } else {

        }
    });

    balance = parseFloat(transaction_amount) - parseFloat(payments);
    // alert('payments: '+payments+' balance: '+balance);
    $('.co_balance_disp').text(addCommas(balance));
}

function computeCartRaw()
{
    //this function will only compute RAW totals, no discounts/altered prices here
    var sale_price = 0;
    var minimum_price = 0;

    // compute each item's original price
    $('.display_price').each(function(){
        sale_price = sale_price + parseFloat($(this).val());
    });

    // compute each item's minimum price
    $('.min_price').each(function(){
        minimum_price = minimum_price + parseFloat($(this).val());
    });

    // assign new values
    $('#float_cart_orig_price').val(sale_price);
    $('#float_cart_minimum_total').val(minimum_price);

    // display new raw/original cart total
    $('.initial_cart_price').text(addCommas(sale_price));
    $('.updated_cart_price').text(addCommas(sale_price)); //will be overwritten by per-item/bulk if set
    $('.transaction_total').text(addCommas(sale_price));
    $('#transaction_amt_to_pay').val(addCommas(sale_price));
    $('#float_trans_amount').val(sale_price);

    // compute taxes and vat
    computeVATRaw(sale_price);

    // compute minimum
    computeCartMinimum();
}

function computeCartIndiv()
{
    // this function will only compute PER ITEM totals.
    var sale_price = 0;

    // compute each item's original price
    $('.adjusted_price').each(function(){
        sale_price = sale_price + parseFloat($(this).val());
    });


    var orig_price = $('#float_cart_orig_price').val();
    var savings = orig_price - sale_price;

    // display discount amount
    $('#customer_savings').text(addCommas(parseFloat(savings)));

    // assign new values
    $('#float_cart_new_price').val(sale_price);

    // display new cart total
    $('.updated_cart_price').text(addCommas(sale_price));
    $('.transaction_total').text(addCommas(sale_price));
    $('#transaction_amt_to_pay').val(addCommas(sale_price));
    $('#float_trans_amount').val(sale_price);

    // compute taxes and vat
    computeVATIndiv(sale_price);

    // compute cart's minimum price
    computeCartMinimum();
}

function computeCartBulk(sale_price)
{
    // assign new values
    $('#float_cart_new_price').val(sale_price);

    // display new cart total
    $('.updated_cart_price').text(addCommas(sale_price));
    $('.transaction_total').text(addCommas(sale_price));
    $('#transaction_amt_to_pay').val(addCommas(sale_price));
    $('#float_trans_amount').val(sale_price);
    // compute taxes and vat
    computeVATIndiv(sale_price);
    // compute minimum
    computeCartMinimum();
}

function computeVATRaw(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;


    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $('#float_orig_tax_vat_amt').val(round(vat_amt,2));
        $('#float_orig_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#initial_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#initial_vat_amt").text(addCommas(round(vat_amt,2)));
        $("#updated_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $('#float_orig_tax_vat_amt').val(round(vat_amt,2));
        $('#float_orig_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#initial_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#initial_vat_amt").text(addCommas(round(vat_amt,2)));
        $("#updated_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {
        $("#cart_new_amt_vat").text("No vat set in ERP");
        $("#cart_new_vat").text("No vat set in ERP");
    }
}

function computeVATIndiv(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#updated_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#updated_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {
        $("#cart_new_amt_vat").text("No vat set in ERP");
        $("#cart_new_vat").text("No vat set in ERP");
    }
}

function computeCartMinimum()
{
    var total = 0;
    $('.min_price').each(function(){
        total = total + parseFloat($(this).val());
    });

    if ($('#string_trans_mode').val() == 'normal') {
        var additional_ea = $('#transaction_parent_ea').val();
        additional_ea = additional_ea.replace(/-/g, "");
    } else {
        var additional_ea = '0';
    }

    var orig = parseFloat($('#float_cart_orig_price').val()) + parseInt(additional_ea);
    var new_total = parseFloat($('#float_cart_new_price').val()) + parseInt(additional_ea);

    $("#float_cart_minimum_total").val(total);

    if ($('#string_trans_type').val() == 'none') {
        if (total > orig) {
            $('.updated_price_h3').css({'color': 'red'});
        } else {
            $('.updated_price_h3').css({'color': 'black'});
        }
    } else {
        if (total > new_total) {
            $('.updated_price_h3').css({'color': 'red'});
        } else {
            $('.updated_price_h3').css({'color': 'black'});
        }
    }

    computeExtraAmount();
}

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

function computeRefundVATBalance(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#float_refund_balance_tax_vat_amt').val(vat_amt);
        $('#float_refund_balance_tax_amt_net_vat').val(amt_net_of_vat);
        $("#balance_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#balance_refund_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_refund_balance_tax_vat_amt').val(vat_amt);
        $('#float_refund_balance_tax_amt_net_vat').val(amt_net_of_vat);
        $("#balance_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#balance_refund_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {

    }
}

function computeExtraAmount()
{
    var cart_min_price = 0;
    var cart_price = 0;



    if ($('#flag_refund').val() == 'true') {
        var minimum_price = 0;
        var existing_minimum_price = 0;
        // compute each item's minimum price
        $('.min_price').each(function(){
            minimum_price = minimum_price + parseFloat($(this).val());
        });

        $('.refund_issued:checkbox:not(:checked)').each(function () {
            var row = $(this).closest('.existing_product_row');
            var ext_min_price = row.find('.existing_min_price');
            existing_minimum_price += parseFloat(ext_min_price.val());
        });

        cart_min_price = minimum_price + existing_minimum_price;

        if ($('#string_trans_mode').val() == 'normal') {
            var additional_ea = $('#transaction_parent_ea').val();
            additional_ea = additional_ea.replace(/-/g, "");
        } else {
            var additional_ea = '0';
        }

        if ($('#string_trans_type').val() == 'none' || $('#string_trans_type').val() == 'reg') {
            cart_price = parseInt($("#ovr_float_cart_orig_price").val());
        } else {
            cart_price = parseInt($("#ovr_float_cart_new_price").val());
        }
    } else {
        cart_min_price = parseInt($("#float_cart_minimum_total").val());

        if ($('#string_trans_mode').val() == 'normal') {
            var additional_ea = $('#transaction_parent_ea').val();
            additional_ea = additional_ea.replace(/-/g, "");
        } else {
            var additional_ea = '0';
        }

        if ($('#string_trans_type').val() == 'none' || $('#string_trans_type').val() == 'reg') {
            cart_price = parseInt($("#float_cart_orig_price").val());
        } else {
            cart_price = parseInt($("#float_cart_new_price").val());
        }
    }



    var extra_amt = (cart_price - cart_min_price) + parseInt(additional_ea);
    var extra_amt_disp = addDashes(extra_amt.toString());
    $('#cart_min_pricex').text(addCommas(cart_min_price));
    $('#cart_pricex').text(addCommas(cart_price));
    $('#ea_amt').text(extra_amt_disp);
    $('#float_trans_ea').val(extra_amt_disp);
}