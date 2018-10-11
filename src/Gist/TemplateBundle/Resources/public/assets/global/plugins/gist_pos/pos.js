
function revertDiscounts()
{
    if ($('#string_trans_mode').val() == 'Deposit') {
        $('#cart_table').find('tr').each(function(){
            if ($(this).children('th').length > 5) {
                $(this).find('th').eq(3).remove();
                $(this).find('th').eq(3).remove();
                $(this).find('th').eq(3).remove();
                $(this).find('td').eq(0).css('width','350px');
                $(this).find('td').eq(1).css('width','100px');
            }

            if ($(this).children('td').length > 5) {
                $(this).find('td').eq(3).remove();
                $(this).find('td').eq(3).remove();
                $(this).find('td').eq(3).remove();
                $(this).find('td').eq(0).css('width','350px');
                $(this).find('td').eq(1).css('width','100px');
            }
        });
    } else {
        $('#cart_table').find('tr').each(function(){
            if ($(this).children('th').length > 5) {
                $(this).find('th').eq(2).remove();
                $(this).find('th').eq(2).remove();
                $(this).find('th').eq(2).remove();
                $(this).find('td').eq(0).css('width','350px');
                $(this).find('td').eq(1).css('width','100px');
            }

            if ($(this).children('td').length > 5) {
                $(this).find('td').eq(2).remove();
                $(this).find('td').eq(2).remove();
                $(this).find('td').eq(2).remove();
                $(this).find('td').eq(0).css('width','350px');
                $(this).find('td').eq(1).css('width','100px');
            }
        });
    }

    var float_orig_price = parseFloat($('#float_cart_orig_price').val());
    $('#string_trans_type').val('none');
    $('.updated_totals_row').hide();
    $('.checkout_btn').hide();
    $('.bulk_adj').hide();
    $('#customer_savings').text("0.00");
    $('.next_step_btn').show();
    $('.clear_discount').hide();
    $('.initial_cart_price').text(addCommas(float_orig_price));
    $('#float_cart_new_price').val($('#float_cart_orig_price').val());



    // $('.cart_price_h3').css({'color': 'black'});
    $('#cgroup-new_total').hide();
    $('#cform-new_total').val('');
    $('#cform-discount_amount').val('');
    $('#cgroup-discount_amount').hide();
    $('#cform-discount_pct').val('');
    $('#cgroup-discount_pct').hide();
    // $('.cart_price').text(addCommas($('#float_cart_orig_price').val()));

    computeCartRaw();
    $('.orig_totals_row').hide();
    $('.orig_price_h3').hide();
    $('.bulk_discount_h4').hide();
    $('#applied_bulk_discount').text('');
}

function ajaxGetProductCategories()
{
    var url_pos = $('#url_pos').val();
    var url_erp = $('#url_erp').val();
    var pos_loc_id = $('#pos_loc_id').val();

    $( "#prod_cats" ).empty();
    $( "#prods" ).empty();
    $("#prod_cats").append("<div style=\"height: 10px;\">");
    var url = url_erp+"/inventory/pos/get/product_categories";
    $.getJSON(url, function(json){
       $.each(json, function(i, item) {
            var img = "http://nahmdong.com/vitalhill/img/default.png";
            if (item.image_url != null) {
                img = item.image_url;
            }
           $("#prod_cats").append("<li class=\"nav-item\">\
                <a aria-controls=\"pills-"+item.id+"\" aria-selected=\"false\" class=\"nav-link\" data-toggle=\"pill\" href=\"#pills-"+item.id+"\" id=\"pills-"+item.id+"\" role=\"tab\" onclick=\"ajaxGetProducts("+item.id+")\">"+item.name+"</a>\
            </li>");

           $("#prods").append("<div class=\"col-sm-6 col-12 item\">\
            <a href=\"javascript:void(0)\" style=\"text-decoration: none;\" onclick=\"ajaxGetProducts("+item.id+")\">\
                <div class=\"item-content\">\
                    <img src="+img+">\
                    <div class=\"item-details\">\
                        <div class=\"item-title\">"+item.name+"</div>\
                    </div>\
                </div>\
            </a>\
            </div>");
        });
    });
}

function ajaxGetProducts(cid)
{
    var url_pos = $('#url_pos').val();
    var url_erp = $('#url_erp').val();
    var pos_loc_id = $('#pos_loc_id').val();
    $( "#prods" ).empty();
    $("#prods").append("<div class=\"col-md-12\"><h2>&nbsp;&nbsp;&nbsp;Loading products...</h2></div>");
    $("#cat_btn_"+cid).css({'background-color': '#484c50'});
    $( "#prods" ).empty();

    var url = url_erp+"/inventory/pos/get/products/"+pos_loc_id+"/"+cid;
    $.getJSON(url, function(json){
        var count = 0;
       $.each(json, function(i, item) {
        count++;
        var price = 0;
        var orig_srp = 0;
        if (item.srp != null) {
            price = item.srp;
        }

        if (item.orig_srp != null) {
            orig_srp = item.orig_srp;
        }

        var img = "http://nahmdong.com/vitalhill/img/default.png";
        if (item.image_url != null) {
            img = item.image_url;
        }

           $("#prods").append("<div class=\"col-sm-6 col-12 item\">\
            <a href=\"javascript:void(0)\" style=\"text-decoration: none;\" onclick=\"addToCart('"+item.name+"',"+price+","+item.min_price+","+item.id+",'"+item.barcode+"','"+item.item_code+"')\">\
                <div class=\"item-content\" data-title="+item.name+" data-price="+orig_srp+">\
                    <img src="+img+" alt="+item.name+">\
                    <div class=\"item-details\">\
                        <div class=\"item-title\">"+item.name+"</div>\
                        <div class=\"item-price\">PHP "+orig_srp+"</div>\
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

function addToPayments(payment_type, amount, details, cc_number, cc_bank, cc_terminal_opt, cc_interest, cc_terms, account_number, payee, payor, expiry, cvv, check_date, check_type)
{
    cc_bank = cc_bank || "";
    cc_interest = cc_interest || "";
    cc_number = cc_number || "";
    cc_terminal_opt = cc_terminal_opt || "";
    cc_terms = cc_terms || "";
    account_number = account_number || "";
    payee = payee || "";
    payor = payor || "";
    expiry = expiry || "";
    cvv = cvv || "";
    check_date = check_date || "";
    check_type = check_type || "";

    $('.init_row_payment').remove();

    var row_id = Math.round(new Date().getTime() + (Math.random() * 100));
    var field = '<tr class=\"row_payment_'+row_id+'\">';
        field += '<input type=\"hidden\" name=\"control_number\" class=\"control_number\" value=\"'+cc_number+'\">';
        field += '<input type=\"hidden\" name=\"account_number\" class=\"account_number\" value=\"'+account_number+'\">';
        field += '<input type=\"hidden\" name=\"bank\" class=\"bank\" value=\"'+cc_bank+'\">';
        field += '<input type=\"hidden\" name=\"payment_issued_on\" class=\"payment_issued_on\" value=\"0\">';
        field += '<input type=\"hidden\" name=\"cc_terminal_opt\" class=\"cc_terminal_opt\" value=\"'+cc_terminal_opt+'\">';
        field += '<input type=\"hidden\" name=\"cc_interest\" class=\"cc_interest\" value=\"'+cc_interest+'\">';
        field += '<input type=\"hidden\" name=\"cc_terms\" class=\"cc_terms\" value=\"'+cc_terms+'\">';
        field += '<input type=\"hidden\" name=\"payee\" class=\"payee\" value=\"'+payee+'\">';
        field += '<input type=\"hidden\" name=\"payor\" class=\"payor\" value=\"'+payor+'\">';
        field += '<input type=\"hidden\" name=\"cc_expiry\" class=\"cc_expiry\" value=\"'+expiry+'\">';
        field += '<input type=\"hidden\" name=\"cc_cvv\" class=\"cc_cvv\" value=\"'+cvv+'\">';
        field += '<input type=\"hidden\" name=\"check_type\" class=\"check_type\" value=\"'+check_type+'\">';
        field += '<input type=\"hidden\" name=\"check_date\" class=\"check_date\" value=\"'+check_date+'\">';
        field += '<input type=\"hidden\" name=\"payment_details_array[]\" class=\"payment_details_array\" value=\"'+details+'\" >';
        field += '<input type=\"hidden\" name=\"payment_amt_float[]\" class=\"payment_amt_float\" value=\"'+amount+'\" >';
        field += '<td><input type="text" style=\"font-size: 12px !important;\" name="payment_type[]" value="'+payment_type+'" readonly="true" class="form-control payment_type"></td>';
        field += '<td><input type="text" style=\"font-size: 10px !important;\" name="payment_amt[]" class="form-control payment_amt" readonly="true" value="'+addCommas(amount)+'"></td>';
        field += '<td ><a href="javascript:void(0)" class="btn btn-xs default red remove_payment_row"><i class="fa fa-times" aria-hidden="true"></i></a></td>';
        field += '</tr>';

        $('#payments_list').prepend(field);
        toastr['success']('Payment added', 'Success');
        computeBalance();
}

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
            field += '<td><a href="javascript:void(0)" class="btn btn-xs default green view_customer_btn" data-toggle="tooltip" data-placement="bottom" title="View Customer"><i class="fa fa-eye" aria-hidden="true"></i></a>';
            field += '<a href="javascript:void(0)" class="btn btn-xs default blue use_customer_btn" data-toggle="tooltip" data-placement="bottom" title="Select Customer"><i class="fa fa-pencil" aria-hidden="true"></i></a></td>';
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

function addCommas(nStr)
{
    //if (nStr != "" && parseFloat(nStr) > 0) {
        nStr = nStr.toFixed(2);
        nStr += '';
        x = nStr.split('.');
        x1 = x[0];
        x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
        }

        var ret_val = x1+x2;
        return ret_val;
    // } else {
    //     return "0.00";
    // }
}

function round(value, exp) {
  if (typeof exp === 'undefined' || +exp === 0)
    return Math.round(value);

  value = +value;
  exp = +exp;

  if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0))
    return NaN;

  value = value.toString().split('e');
  value = Math.round(+(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp)));

  value = value.toString().split('e');
  return +(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp));
}




function addToCart(product_name, srp, min_price, id, barcode, item_code)
{
    var trans_type = $('#string_trans_type').val();
    var trans_mode = $('#string_trans_mode').val();

    $('.init_row_prods').remove();
    var row_id = Math.round(new Date().getTime() + (Math.random() * 100));

    //construct cart row
    var field = '<tr class=\"row_prod_'+row_id+'\ product_row">';
    field += '<input type=\"hidden\" name=\"product_id[]\" class=\"product_id\" value=\"'+id+'\" >';
    field += '<input type=\"hidden\" name=\"issued_on[]\" class=\"issued_on\" value=\"0\" >';
    field += '<input type=\"hidden\" name=\"barcode[]\" class=\"barcode\" value=\"'+barcode+'\" >';
    field += '<input type=\"hidden\" name=\"item_code[]\" class=\"item_code\" value=\"'+item_code+'\" >';
    field += '<input type=\"hidden\" name=\"min_price[]\" class=\"min_price\" value=\"'+min_price+'\" >';
    field += '<input type=\"hidden\" name=\"srp[]\" class=\"srp\" value=\"'+srp+'\" >';
    field += '<input type=\"hidden\" name=\"product_amt[]\" class=\"product_amt\" value=\"'+srp+'\" >';
    field += '<td><input type="text" style=\"font-size: 10px !important;\" value="'+product_name+'" readonly="true" class="form-control item_name"></td>';
    field += '<td><input type="text" style=\"font-size: 10px !important;\" name="display_price[]" class="form-control display_price" readonly="true" value="'+srp+'"></td>';
    field += '<td ><a href="javascript:void(0)" class="btn btn-xs default red remove_row"><i class="fa fa-times" aria-hidden="true"></i></a></td>';
    field += '</tr>';


    //append selected item to cart
    $('#cart_items').prepend(field);

    //if transaction mode is deposit, add deposit fields
    if (trans_mode == 'Deposit') {
        appendDepositItemFields();
    }

    //if discount type is per item, add discount fields
    if(trans_type == 'per') {
        appendPerItemFields();
    }

    //count number of products in cart
    var rowCount = $('#cart_table tr').length-1;
    $('.cart_items_count').text(rowCount.toString());

    //compute raw amounts/values (no alterations or discounts)
    if (trans_type == 'none') {
        computeCartRaw();
    } else if (trans_type == 'per') {
        computeCartRaw();
        computeCartIndiv();
    } else if (trans_type == 'reg') {
        computeCartRaw();
    } else if (trans_type == 'bulk') {
        computeCartRaw();
        applyBulkAdjustment();
    }
    computeBalance();
}


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

function proceedToTransaction(x)
{
    var select_trans = x;
    if (select_trans != '') {
        if (select_trans == 'reg') {
            $('.reason_refund_proceed_btn').hide();
            $('.next_step_btn').hide();
            $('.checkout_btn').show();
            $('#transaction_type_modal').modal('hide');
            $('.savings_h4').hide();
            $('.clear_discount').show();
            $('#string_trans_type').val('reg');
        } else if (select_trans == 'per') {
            $('#string_trans_type').val('per');
            $('.reason_refund_proceed_btn').hide();
            $('.next_step_btn').hide();
            $('.savings_h4').show();
            $('.checkout_btn').show();
            appendPerItemColumns();
            appendPerItemFields();
            $('#transaction_type_modal').modal('hide');
            $('.updated_totals_row').show();
            $('.clear_discount').show();
        } else if (select_trans == 'bulk') {
            $('#string_trans_type').val('bulk');
            $('.updated_totals_row').show();
            $('.reason_refund_proceed_btn').hide();
            $('.next_step_btn').hide();
            $('.savings_h4').show();
            $('.bulk_adj').show();
            $('#proc').show();
            $('#transaction_type_modal').modal('hide');
            $('#bulk_adjustment').modal('show');
            $('.bulk_discount_h4').show();
            $('.checkout_btn').show();
            $('.clear_discount').show();
        } else {
            $('.clear_discount').hide();
            $('#string_trans_type').val('none');
        }
    } else {
        $('.clear_discount').hide();
        $('#string_trans_type').val('none');
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

function clearCreditCardModal()
{
    $('#cc_form').empty();
    $("#cc_fields").children().clone(true,true).find("input").val("").end().appendTo('#cc_form');
}

function clearCheckModal()
{
    $('#check_form').empty();
    $("#check_fields").clone().find("input").val("").end().appendTo('#check_form');
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

function revertOriginalPrices()
{
    $('.display_price').each(function() {
        if ($(this).val() == "0" || $(this).val() == 0.00) {
            //revert prices only if bulk discount came from gift
            var row = $(this).closest('tr');
            var srp = row.find('.srp').val();
            $(this).val(srp);
        }

    });
    computeCartMinimum();
}

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

