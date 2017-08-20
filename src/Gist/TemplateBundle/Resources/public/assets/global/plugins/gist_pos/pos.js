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

            $("#prods").append("<div class=\"col-md-2\" style=\"margin: 0px !important; padding: 1px !important\" >\
                    <a href=\"javascript:void(0)\" class=\"category_btn2\" style=\"text-decoration: none;\" onclick=\"ajaxGetProducts("+item.id+")\">\
                    <div class=\"thumbnail\" style=\"margin: 0px !important;border-width: 1px !important; border-color: #5d5d5d !important; border-radius: 5px !important;\">\
                        <img src="+img+" style=\"height: 90px; width: 60%; display: block;\">\
                        <div class=\"caption\" style=\"font-size: 10px !important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">\
                            <h3 style=\"font-size: 10px !important; margin: 0!important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">"+item.name+"</h3>\
                        </div>\
                    </div>\
                    </a>\
                </div>");
        });
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

            $("#prods").append("<div class=\"col-md-2\" style=\"margin: 0px !important; padding: 2px !important\" >\
                    <a href=\"javascript:void(0)\" style=\"text-decoration: none;\" onclick=\"addToCart('"+item.name+"',"+price+","+item.min_price+","+item.id+")\">\
                    <div class=\"thumbnail\" style=\"margin: 0px !important; border-width: 1px !important; border-color: #5d5d5d !important; border-radius: 5px !important;\">\
                        <img src="+img+" style=\"height: 90px; width: 60%; display: block;\">\
                        <div class=\"caption\" style=\"font-size: 10px !important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">\
                            <h3 style=\"font-size: 10px !important; margin: 0!important; text-overflow: ellipsis !important; white-space: nowrap; overflow: hidden;\">"+item.name+"</h3>\
                            <h3 style=\"font-size: 12px !important; margin: 0!important;\"><b>PHP "+price+"</b></h3>\
                        </div>\
                    </div>\
                    </a>\
                </div>");

        });

       if (count == 0) {
            $( "#prods" ).empty();
            $("#prods").append("<div class=\"col-md-12\"><div class=\"alert alert-warning\"> <h2>&nbsp;&nbsp;No products in selected category</h2></div></div>");
       }
    });
}