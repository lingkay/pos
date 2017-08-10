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
        
        if($('.checkout_btn').is(':visible') && $('.bulk_adj').is(':hidden')) {
            appendPerItemFields();
        } else {
            computeCart();
        }
        
        computeCartMinimum();
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



