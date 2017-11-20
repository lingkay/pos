function computeRefundTotal()
{

    var new_total = 0;
    var transaction_total = parseFloat($('#float_trans_amount').val()); //new cart total
    var existing_items_total = 0;
    var orig_total = 0;

    $('.refund_issued:checkbox:not(:checked)').each(function () {
        var row = $(this).closest('.existing_product_row');
        var srp = 0;

        if ($('#string_parent_trans_type').val() == "per") {
            srp = row.find('.existing_adjusted_price');
        } else {
            srp = row.find('.existing_srp');
        }
        var orig_srp = row.find('.existing_srp');
        orig_total += parseFloat(orig_srp.val());
        srp = srp.val();
        existing_items_total += parseFloat(srp);
    });

    new_total = transaction_total + existing_items_total;
    orig_total += transaction_total;

    $('.refund_new_total').text(addCommas(new_total));
    $('#ovr_float_trans_amount').val(new_total);
    $('#ovr_float_cart_orig_price').val(orig_total);
    $('#ovr_float_cart_new_price').val(new_total);

    computeRefundVAT(new_total);
    computeOrigRefundVAT(orig_total);
}

function computeRefundVAT(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#ovr_float_new_tax_vat_amt').val(vat_amt);
        $('#ovr_float_new_tax_amt_net_vat').val(amt_net_of_vat);
        $("#refund_new_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#refund_new_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#ovr_float_new_tax_vat_amt').val(vat_amt);
        $('#ovr_float_new_tax_amt_net_vat').val(amt_net_of_vat);
        $("#refund_new_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#refund_new_vat_amt").text(addCommas(round(vat_amt,2)));
    }
}

function computeOrigRefundVAT(total)
{
    var tax_rate = parseFloat($('#float_tax_rate').val())/100;
    var tax_coverage = $('#string_tax_coverage').val();
    var vat_amt = 0;
    var amt_net_of_vat = 0;
    var incl_divisor = tax_rate + 1;

    if (tax_coverage == 'incl') {
        vat_amt = total*tax_rate;
        amt_net_of_vat = total - vat_amt;

        $('#ovr_float_orig_tax_vat_amt').val(vat_amt);
        $('#ovr_float_orig_tax_amt_net_vat').val(amt_net_of_vat);
        $("#refund_new_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#refund_new_vat_amt").text(addCommas(round(vat_amt,2)));
    } else if (tax_coverage == 'excl') {
        vat_amt = total - (total/incl_divisor);
        amt_net_of_vat = total - vat_amt;

        $('#ovr_float_orig_tax_vat_amt').val(vat_amt);
        $('#ovr_float_orig_tax_amt_net_vat').val(amt_net_of_vat);
        $("#refund_new_amt_net_vat").text(addCommas(round(amt_net_of_vat,2)));
        $("#refund_new_vat_amt").text(addCommas(round(vat_amt,2)));
    }
}