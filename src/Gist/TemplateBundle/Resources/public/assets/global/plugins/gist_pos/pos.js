function addToCart(product_name, srp, min_price, id)
{
    //id = erp product id
    var row_id = Math.round(new Date().getTime() + (Math.random() * 100));
    var field = '<tr class=\"row_prod_'+row_id+'\">';     
        field += '<input type=\"hidden\" name=\"product_id[]\" class=\"product_id\" value=\"'+row_id+'\" >';
        field += '<input type=\"hidden\" name=\"min_price[]\" class=\"min_price\" value=\"'+min_price+'\" >';
        field += '<input type=\"hidden\" name=\"srp[]\" class=\"srp\" value=\"'+srp+'\" >';
        field += '<input type=\"hidden\" name=\"product_amt[]\" class=\"product_amt\" value=\"'+srp+'\" >';
        field += '<td><input type="text" style=\"font-size: 10px !important;\" value="'+product_name+'" readonly="true" class="form-control item_name"></td>';
        field += '<td><input type="text" style=\"font-size: 10px !important;\" name="display_price[]" class="form-control display_price" readonly="true" value="'+srp+'"></td>';  
        field += '<td ><a href="javascript:void(0)" class="btn btn-xs default red remove_row"><i class="fa fa-times" aria-hidden="true"></i></a><a href="javascript:void(0)" class="btn btn-xs default green indiv_adj"><i class="fa fa-pencil" aria-hidden="true"></i></a></td>'; 
        field += '</tr>';

        $('#cart_items').prepend(field);
        hideItemAdjustment();
        if($('.checkout_btn').is(':visible') && $('.bulk_adj').is(':hidden') && $('#reg_trans_flag').val() != 1) {
            appendPerItemFields();
        } else {
            computeCart();
        }
        
        computeCartMinimum();
}

function ajaxGetProductCategories()
{
    $( "#prod_cats" ).empty();
    $( "#prods" ).empty();
    $("#prod_cats").append("<div style=\"height: 10px;\">");
    // var url = "http://dev.gisterp2/inventory/pos/get/product_categories";
    var url = "http://erp.cilanthropist.co/inventory/pos/get/product_categories";
    $.getJSON(url, function(json){  
       $.each(json, function(i, item) {
            var img = "http://nahmdong.com/vitalhill/img/default.png";
            if (item.image_url != null) {
                img = item.image_url;
            }
            // alert(item.name);
            $("#prod_cats").append("<button class=\"btn btn-md btn-block category_btn\" id=\"cat_btn_"+item.id+"\" onclick=\"ajaxGetProducts("+item.id+")\" style=\"background-color: #556E93; color: #ffffff; border-radius: 5px !important;\">"+item.name+"</button>");

            $("#prods").append("<div class=\"col-md-6\" style=\"margin: 0px !important; padding: 1px !important\" >\
                    <a href=\"javascript:void(0)\" class=\"category_btn2\" style=\"text-decoration: none;\" onclick=\"ajaxGetProducts("+item.id+")\">\
                    <div class=\"thumbnail\" style=\"margin: 0px !important;border-width: 1px !important; border-color: #7e88ff !important; border-radius: 5px !important;\">\
                        <img src="+img+" style=\"height: 150px; width: 80%; display: block;\">\
                        <div class=\"caption\" style=\"font-size: 12px !important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">\
                            <h3 style=\"font-size: 12px !important; margin: 0!important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">"+item.name+"</h3>\
                        </div>\
                    </div>\
                    </a>\
                </div>");
        });
    });
}
function ajaxGetVAT()
{
    // var url = "http://dev.gisterp2/inventory/pos/get/vat";
    var url = "http://erp.cilanthropist.co/inventory/pos/get/vat";
    var vat = 0;
    $.getJSON(url, function(json){  
        $('#session_vat').val(json)
    });

}
function ajaxGetProducts(cid)
{

    $( "#prods" ).empty();
    $("#prods").append("<div class=\"col-md-12\"><h2>&nbsp;&nbsp;&nbsp;Loading products...</h2></div>");
    $("#cat_btn_"+cid).css({'background-color': '#484c50'});
    $( "#prods" ).empty();
    
    // var url = "http://dev.gisterp2/inventory/pos/get/products/"+cid;
    var url = "http://erp.cilanthropist.co/inventory/pos/get/products/"+cid;
    $.getJSON(url, function(json){  
        var count = 0;
       $.each(json, function(i, item) {
        count++;
        var price = 0;
        if (item.srp != null) {
            price = item.srp;
        } 

        var img = "http://nahmdong.com/vitalhill/img/default.png";
        if (item.image_url != null) {
            img = item.image_url;
        }

            $("#prods").append("<div class=\"col-md-6\" style=\"margin: 0px !important; padding: 2px !important\" >\
                    <a href=\"javascript:void(0)\" style=\"text-decoration: none;\" onclick=\"addToCart('"+item.name+"',"+price+","+item.min_price+","+item.id+")\">\
                    <div class=\"thumbnail\" style=\"margin: 0px !important; border-width: 1px !important; border-color: #7e88ff !important; border-radius: 5px !important;\">\
                        <img src="+img+" style=\"height: 150px; width: 80%; display: block;\">\
                        <div class=\"caption\" style=\"font-size: 12px !important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">\
                            <h3 style=\"font-size: 12px !important; margin: 0!important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">"+item.name+"</h3>\
                            <h3 style=\"font-size: 12px !important; margin: 0!important;\"><b>PHP "+price+"</b></h3>\
                        </div>\
                    </div>\
                    </a>\
                </div>");

        });

       if (count == 0) {
            $( "#prods" ).empty();
            $("#prods").append("<div class=\"col-md-12\"><h2>&nbsp;&nbsp;No products in selected category</h2></div>");
       }
    });
}

function computeExtraAmount()
{
    var cart_min_price = parseInt($("#cart_min_price").val());
    var cart_price = parseInt($("#cart_int_price").val());
    var extra_amt = cart_price - cart_min_price;
    var extra_amt_disp = addDashes(extra_amt.toString());
    $('#cart_min_pricex').text(addCommas(cart_min_price.toString()));
    $('#cart_pricex').text(addCommas(cart_price.toString()));
    $('#ea_amt').text(extra_amt_disp);
}


function hideItemAdjustment()
{
    $('.indiv_adj').each(function() {
        $(this).hide();
    });
}
function showItemAdjustment()
{
    $('.indiv_adj').each(function() {
        $(this).show();
    });
}

function addCommas(nStr)
{
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function addDashes(nStr)
{
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '-' + '$2');
    }
    return x1 + x2;
}

function appendPerItemColumns()
{
    $('#cart_table').find('tr').each(function(){
        $(this).find('th').eq(1).after('<th>Discount Type</th>');
    });

    $('#cart_table').find('tr').each(function(){
        $(this).find('th').eq(2).after('<th>Value</th>');
    });

    $('#cart_table').find('tr').each(function(){
        $(this).find('th').eq(3).after('<th>Adjusted Price</th>');
    });
    var ths = $('th');
    var element = ths.eq(0);
    element.width(170);
    var element2 = ths.eq(1);
    element2.width(75);
    var element2 = ths.eq(3);
    element2.width(75);
    var element2 = ths.eq(4);
    element2.width(75);
}


function appendPerItemFields()
{
    if ($('.checkout_btn').is(':visible') && $('#reg_trans_flag').val() != 1) {
        $('#cart_table').find('tr').each(function(){
            if ($(this).children('td').length < 6) {
                $(this).find('td').eq(1).after("<td style=\"font-size: 10px !important;\">\
                    {{ form.group_select_only3('Type', 'indiv_disc_opt', indiv_options, '', 12, 12, false)|e('js') }}</td>");
                $(this).find('td').eq(2).after("<td style=\"font-size: 10px !important;\">\
                    <input type=\"text\" style=\"font-size: 10px !important;\" class=\"form-control per_item_discount_amt\" readonly=\"true\" value=\"\"></td>");
                $(this).find('td').eq(3).after('<td><input type="text" style=\"font-size: 10px !important;\" class="form-control adjusted_price" readonly="true" value="0.00"></td>');

                var srp = $(this).find('.srp').val();
                var ap = $(this).find('.adjusted_price');
                ap.val(srp);
                computeCart();
            }
        });
    }
}

function hideBulkAmounts()
{
    $('#cform-discount_amount').val('');
    $('#cgroup-discount_amount').hide();
    $('#cform-discount_pct').val('');
    $('#cgroup-discount_pct').hide();
    $('#cform-new_total').val('');
    $('#cgroup-new_total').hide();
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


function hideCartLastColumn()
{
    $('td:last-child').each(function(){
        if ($(this).closest('table').attr('id') == 'cart_table') {
            $(this).css("display", "none");    
        }
        
    });

    $('th:last-child').each(function(){
        if ($(this).closest('table').attr('id') == 'cart_table') {
            $(this).css("display", "none");
        }
    });
}

function showCartLastColumn()
{
    ('td:last-child').each(function(){
        if ($(this).closest('table').attr('id') == 'cart_table') {
            $(this).css("display", "");
        }
    });

    $('th:last-child').each(function(){
        if ($(this).closest('table').attr('id') == 'cart_table') {
            $(this).css("display", "");
        }
    });
}


function applyIndividualAdjustment()
{   
    var indiv_adj_opt = $('#cform-indiv_adj').val();
    if (indiv_adj_opt != '') {
        var selected_prod_id = $('#item_adjustment_prod_id').val();
        var row = $("#cart_table > tbody > tr.row_prod_"+selected_prod_id);
        var srp = row.find('.srp').val();

        if (indiv_adj_opt == 'gift') {
            row.find('.display_price').val('0.00');
        } else if (indiv_adj_opt == '40p') {
            var discounted_srp = srp * .4;
            row.find('.display_price').val(discounted_srp);
        } else if (indiv_adj_opt == 'chg') {
            row.find('.display_price').val($('#cform-new_price').val());
        } else {
            row.find('.display_price').val(srp);
        }
    } else {

    }
}



function apply_indiv(x)
{
    var row = $(x).closest('tr');
    var srp = row.find('.srp').val();
    var adjusted_price = row.find('.adjusted_price');
    var per_item_discount_amt = row.find('.per_item_discount_amt');
    //adjusted_price.val(parseInt(srp)+100);

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
    } else {
        adjusted_price.val(srp);
        per_item_discount_amt.attr("readonly", true); 
        per_item_discount_amt.val('');
    }

    computeCart();
    computeCartMinimum();
}

