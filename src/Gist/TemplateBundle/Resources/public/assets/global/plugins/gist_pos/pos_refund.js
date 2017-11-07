//Create function

function computeRefundBalance()
{
    //sum payments first then subtract to transaction amount
    var payments = 0;
    var transaction_amount = $('#float_trans_amount').val();
    var balance = 0;
    $('.payment_amt_float').each(function(){
        payments = payments + parseFloat($(this).val());
    });

    //get refund amount, count checked items in existing cart
    var refund_total = 0;
    $('.refund_issued:checkbox:checked').each(function () {
        var row = $(this).closest('.product_row');

        if ($('#string_trans_type').val() == 'per') {
            var ap = row.find('.adjusted_price');
            ap = ap.val();
            refund_total += parseFloat(ap);
        } else {
            var srp = row.find('.srp');
            srp = srp.val();
            refund_total += parseFloat(srp);
        }
    });

    var newCartTotal = 0;
    $('.display_refund_price').each(function(){
        newCartTotal = newCartTotal + parseFloat($(this).val());
    });

    balance = ((transaction_amount - refund_total) - payments) + newCartTotal;
    // console.log('BALANCE FROM REF COMP BAL: '+ balance);
    // console.log('transaction_amount: '+ transaction_amount);
    // console.log('payments: '+ payments);
    // console.log('refund_total: '+ refund_total);
    // console.log('newCartTotal: '+ newCartTotal);

    $('#float_refund_trans_balance').val(balance);
    $('.totals_refund_balance').text(addCommas(balance));
    $('.co_balance').text(addCommas(balance));
    $('.co_balance_static').text(addCommas(balance));
    $('.co_balance_disp').text(addCommas(balance));

    computeRefundVATBalance(balance);
}

function computeRefundBalanceDisplay(amt)
{

    var payments = amt;
    var transaction_amount = $('#float_refund_trans_balance').val();
    var balance = 0;


    balance = transaction_amount - payments;
    $('.co_balance_disp').text(addCommas(balance));

}


function computeRefundBalanceDisplayCardMulti()
{
    var payments = 0;
    var transaction_amount = $('#float_refund_trans_balance').val();
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

function computeRefundBalanceDisplayCheckMulti()
{
    var payments = 0;
    var transaction_amount = $('#float_refund_trans_balance').val();
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

function computeRefundCartRaw()
{
    //this function will only compute RAW totals, not discounts/altered prices here
    var sale_price = 0;
    var minimum_price = 0;

    // compute each item's original price
    $('.display_refund_price').each(function(){
        sale_price = sale_price + parseFloat($(this).val());
    });

    // compute each item's minimum price
    $('.min_refund_price').each(function(){
        minimum_price = minimum_price + parseFloat($(this).val());
    });

    // assign new values
    $('#float_refund_cart_orig_price').val(sale_price);
    $('#float_refund_cart_minimum_total').val(minimum_price);



    //sale_price = sale_price + rem_total;

    // display new raw/original cart total
    $('.initial_refund_cart_price').text(addCommas(sale_price));
    $('.updated_refund_cart_price').text(addCommas(sale_price)); //will be overwritten by peritem/bulk if set
    $('.transaction_refund_total').text(addCommas(sale_price));
    $('#transaction_refund_amt_to_pay').val(addCommas(sale_price));
    $('#float_refund_trans_amount').val(sale_price);

    // compute taxes and vat
    computeRefundVATRaw(sale_price);


    // compute minimum
    computeRefundCartMinimum();
}

function computeRefundCartIndiv()
{
    //this function will only compute PER ITEM totals.
    var sale_price = 0;


    // compute each item's original price
    $('.adjusted_price').each(function(){
        sale_price = sale_price + parseFloat($(this).val());
        // alert($(this).val());
    });

    //ENABLE FOR CUSTOMER REFUND
    //var orig_price = $('#float_refund_cart_orig_price').val();
    //var savings = orig_price - sale_price;

    //$('#customer_refund_savings').text(addCommas(parseFloat(savings)));

    // assign new values
    $('#float_refund_cart_new_price').val(sale_price);

    // display new cart total
    $('.updated_refund_cart_price').text(addCommas(sale_price));
    $('.transaction_refund_total').text(addCommas(sale_price));
    $('#transaction_refund_amt_to_pay').val(addCommas(sale_price));
    $('#float_refund_trans_amount').val(sale_price);
    // compute taxes and vat
    computeVATIndiv(sale_price);

    // compute minimum
    computeRefundCartMinimum();

}

function computeRefundCartBulk(sale_price)
{
    // assign new values
    $('#float_refund_cart_new_price').val(sale_price);

    // display new cart total
    $('.updated_refund_cart_price').text(addCommas(sale_price));
    $('.transaction_refund_total').text(addCommas(sale_price));
    $('#transaction_refund_amt_to_pay').val(addCommas(sale_price));
    $('#float_refund_trans_amount').val(sale_price);
    // compute taxes and vat
    computeRefundVATIndiv(sale_price);
    // compute minimum
    computeRefundCartMinimum();

}




function computeRefundVATRaw(total)
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
        $("#initial_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#initial_refund_vat_amt").text(addCommas(round(vat_amt,2)));
        $("#updated_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_refund_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $('#float_orig_tax_vat_amt').val(round(vat_amt,2));
        $('#float_orig_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#initial_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#initial_refund_vat_amt").text(addCommas(round(vat_amt,2)));
        $("#updated_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_refund_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {
        $("#cart_refund_new_amt_vat").text("No vat set in ERP");
        $("#cart_refund_new_vat").text("No vat set in ERP");
    }


}

function computeRefundVATIndiv(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;
    // console.log("incl_divisor: "+incl_divisor);

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#updated_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_refund_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#float_new_tax_vat_amt').val(round(vat_amt,2));
        $('#float_new_tax_amt_net_vat').val(round(amt_net_of_vat,2));
        $("#updated_refund_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#updated_refund_vat_amt").text(addCommas(round(vat_amt,2)));
    } else {
        $("#cart_refund_new_amt_vat").text("No vat set in ERP");
        $("#cart_refund_new_vat").text("No vat set in ERP");
    }
}

function computeRefundCartMinimum()
{
    var total = 0;
    $('.srp').each(function(){
        total = total + parseFloat($(this).val());
    });



    if ($('#string_trans_mode').val() == 'normal') {
        var additional_ea = $('#transaction_parent_ea').val();
        additional_ea = additional_ea.replace(/-/g, "");
    } else {
        var additional_ea = '0';
    }

    var orig = parseFloat($('#float_refund_cart_orig_price').val()) + parseInt(additional_ea);
    var new_total = parseFloat($('#float_refund_cart_new_price').val()) + parseInt(additional_ea);

    $("#float_refund_cart_minimum_total").val(total);

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

