/* PER ITEM DISCOUNT */
function apply_indiv(x)
{
    // this function will apply each cart item's selected discount
    var row = $(x).closest('tr');
    var srp = row.find('.srp').val();
    var adjusted_price = row.find('.adjusted_price');
    var per_item_discount_amt = row.find('.per_item_discount_amt');

    if ($(x).val() == 'gift') {
        adjusted_price.val(0);
        per_item_discount_amt.attr("readonly", true);
        per_item_discount_amt.val('');
    } else if ($(x).val() == 'disc') {
        adjusted_price.val(srp);
        per_item_discount_amt.val('');
        per_item_discount_amt.attr("readonly", false);
    } else if ($(x).val() == 'chg') {
        adjusted_price.val(srp);
        per_item_discount_amt.val('');
        per_item_discount_amt.attr("readonly", false);
    } else if ($(x).val() == 'discamt') {
        adjusted_price.val(srp);
        per_item_discount_amt.val('');
        per_item_discount_amt.attr("readonly", false);
    }else {
        adjusted_price.val(srp);
        per_item_discount_amt.attr("readonly", true);
        per_item_discount_amt.val('');
    }

    computeCartIndiv();
    computeBalance();
}

/* BULK DISCOUNT */
function applyBulkAdjustment()
{
    var bulk_adj_opt = $('#bulk_opt_sel').val();
    if (bulk_adj_opt != '') {
        if (bulk_adj_opt == 'bgift') {
            computeCartBulk(0);
            $('#string_trans_bulk_type').val('Gift');
            $('#applied_bulk_discount').text('Gift');
            $('#bulk_opt_amt').val('0');
            computeCartBulk(parseFloat('0.00'));
        } else if (bulk_adj_opt == 'bdiscamt') {
            var new_cart_total = $('#float_cart_orig_price').val() - $('#cform-discount_amount').val();
            if (new_cart_total >= 0) {
                $('#applied_bulk_discount').text('Less Php '+$('#cform-discount_amount').val()+'');
                $('#customer_savings').text(addCommas(parseFloat($('#cform-discount_amount').val())));
                $('#string_trans_bulk_type').val('Less Php '+$('#cform-discount_amount').val()+'');
                $('#bulk_opt_amt').val($('#cform-discount_amount').val());
                computeCartBulk(new_cart_total);
            } else {
                toastr['error']('Invalid discount amount.', 'Error');
            }
        } else if (bulk_adj_opt == 'bdisc') {
            var new_cart_total = $('#float_cart_orig_price').val() - ($('#float_cart_orig_price').val() * ($('#cform-discount_pct').val()/100));
            var savings = $('#float_cart_orig_price').val() * ($('#cform-discount_pct').val()/100);
            if (new_cart_total >= 0) {
                computeCartBulk(new_cart_total);
                $('#applied_bulk_discount').text('Less '+$('#cform-discount_pct').val()+' percent off');
                $('#string_trans_bulk_type').val('Less '+$('#cform-discount_pct').val()+' percent off');
                $('#customer_savings').text(addCommas(parseFloat(savings)));
                $('#bulk_opt_amt').val($('#cform-discount_pct').val());
            } else {
                toastr['error']('Invalid discount.', 'Error');
            }
        } else if (bulk_adj_opt == 'bamt') {
            var savings = $('#float_cart_orig_price').val() - $('#cform-new_total').val();
            computeCartBulk(parseFloat($('#cform-new_total').val()));
            $('#applied_bulk_discount').text('Change Amount');
            $('#string_trans_bulk_type').val('Change Amount to pay to: Php ' + $('#cform-new_total').val());
            $('#customer_savings').text(addCommas(parseFloat(savings)));
            $('#bulk_opt_amt').val($('#cform-new_total').val());
        } else {
            $('#string_trans_bulk_type').val('none');
            $('#bulk_opt_amt').val('0');
            $('.display_price').each(function() {
                if ($(this).val() == "0" || $(this).val() == "0.00") {
                    //revert prices only if bulk discount came from gift
                    var row = $(this).closest('tr');
                    var srp = row.find('.srp').val();
                    $(this).val(srp);
                }
            });
            $('#applied_bulk_discount').text('');
            computeCartBulk(0);
        }
    } else {
        $('#string_trans_bulk_type').val('none');
    }
    computeBalance();
}

function updateBulkForm(opt)
{
    var bulk_adj_opt = opt;
    $('.indiv_adj').each(function() {
        $(this).hide();
    });

    if (bulk_adj_opt == 'bgift') {
        $('#bulk_opt_sel').val('bgift');
        $('#cform-discount_amount').val('');
        $('#cgroup-discount_amount').hide();
        $('#cform-discount_pct').val('');
        $('#cform-selected_bulk').val('Gift');
        $('#cgroup-discount_pct').hide();
        $('#cform-new_total').val('');
        $('#cgroup-new_total').hide();
    } else if (bulk_adj_opt == 'bamt') {
        $('#bulk_opt_sel').val('bamt');
        $('#cform-discount_amount').val('');
        $('#cgroup-discount_amount').hide();
        $('#cform-discount_pct').val('');
        $('#cform-selected_bulk').val('Change Amount to Pay');
        $('#cgroup-discount_pct').hide();
        $('#cgroup-new_total').show();
    } else if (bulk_adj_opt == 'bdiscamt') {
        $('#bulk_opt_sel').val('bdiscamt');
        $('#cgroup-discount_amount').show();
        $('#cform-discount_pct').val('');
        $('#cform-selected_bulk').val('Discount Amount');
        $('#cgroup-discount_pct').hide();
        $('#cform-new_total').val('');
        $('#cgroup-new_total').hide();
    } else if (bulk_adj_opt == 'bdisc') {
        $('#bulk_opt_sel').val('bdisc');
        $('#cform-discount_amount').val('');
        $('#cgroup-discount_amount').hide();
        $('#cform-selected_bulk').val('Discount %');
        $('#cgroup-discount_pct').show();
        $('#cform-new_total').val('');
        $('#cgroup-new_total').hide();
    } else {
        $('#bulk_opt_amt').val('0');
        $('#bulk_opt_sel').val('na');
        cancelBulkAdjustment();
    }
}

function applyBulkAdjustmentOnLoad()
{
    var bulk_adj_opt = $('#bulk_opt_sel').val();
    if (bulk_adj_opt != '') {
        if (bulk_adj_opt == 'bgift') {
            computeCartBulk(0);
            $('#string_trans_bulk_type').val('Gift');
            $('#applied_bulk_discount').text('Gift');
            $('#bulk_opt_amt').val('0');
            computeCartBulk(parseFloat('0.00'));
        } else if (bulk_adj_opt == 'bdiscamt') {
            var new_cart_total = $('#float_cart_orig_price').val() - $('#bulk_opt_amt').val();
            if (new_cart_total >= 0) {
                $('#applied_bulk_discount').text('Less Php '+$('#bulk_opt_amt').val()+'');
                $('#customer_savings').text(addCommas(parseFloat($('#bulk_opt_amt').val())));
                $('#string_trans_bulk_type').val('Less Php '+$('#bulk_opt_amt').val()+'');
                computeCartBulk(new_cart_total);
            } else {
                toastr['error']('Invalid discount amount.', 'Error');
            }
        } else if (bulk_adj_opt == 'bdisc') {
            var new_cart_total = $('#float_cart_orig_price').val() - ($('#float_cart_orig_price').val() * ($('#bulk_opt_amt').val()/100));
            var savings = $('#float_cart_orig_price').val() * ($('#bulk_opt_amt').val()/100);
            if (new_cart_total >= 0) {
                computeCartBulk(new_cart_total);
                $('#applied_bulk_discount').text('Less '+$('#bulk_opt_amt').val()+' percent off');
                $('#string_trans_bulk_type').val('Less '+$('#bulk_opt_amt').val()+' percent off');
                $('#customer_savings').text(addCommas(parseFloat(savings)));
            } else {
                toastr['error']('Invalid discount.', 'Error');
            }
        } else if (bulk_adj_opt == 'bamt') {
            var savings = $('#float_cart_orig_price').val() - $('#bulk_opt_amt').val();
            // alert(savings);
            computeCartBulk(parseFloat($('#bulk_opt_amt').val()));
            $('#applied_bulk_discount').text('Change Amount');
            $('#string_trans_bulk_type').val('Change Amount to pay to: Php ' + $('#bulk_opt_amt').val());
            $('#customer_savings').text(addCommas(parseFloat(savings)));
        } else {
            $('#string_trans_bulk_type').val('none');
            $('#bulk_opt_amt').val('0');
            $('.display_price').each(function() {
                if ($(this).val() == "0" || $(this).val() == "0.00") {
                    //revert prices only if bulk discount came from gift
                    var row = $(this).closest('tr');
                    var srp = row.find('.srp').val();
                    $(this).val(srp);
                }
            });
            $('#applied_bulk_discount').text('');
            computeCartBulk(0);
        }
    } else {
        $('#string_trans_bulk_type').val('none');
    }
    computeBalance();
}

function cancelBulkAdjustment()
{
    revertOriginalPrices();
    $('#cgroup-new_total').hide();
    $('#cform-new_total').val('');
    $('#cform-discount_amount').val('');
    $('#cgroup-discount_amount').hide();
    $('#cform-discount_pct').val('');
    $('#cgroup-discount_pct').hide();
    $('.display_price').each(function() {
        if ($(this).val() == "0" || $(this).val() == 0.00) {
            //revert prices only if bulk discount came from gift
            var row = $(this).closest('tr');
            var srp = row.find('.srp').val();
            $(this).val(srp);
        }
    });
}