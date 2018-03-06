$(document).on('turbolinks:load', function(){
  // Event add more 10 rows in create list prospect
  $('#add-more').click(function(e){
    e.preventDefault();
    lastRow = parseInt($('#multi-customer tr:last').attr('id')) + 1;
    html = ''
    for (i = lastRow; i < lastRow + 10; i++) {
      html += '<tr id="' + i + '">';
      html += '<td><label class="control-label col-sm-3" for="stt">' + i + '</label></td>';
      html += '<td><input type="text" name="customers[customers][]customer[last_name]" id="customers_customers_customer_last_name" class="form-control"></td>';
      html += '<td><input type="text" name="customers[customers][]customer[first_name]" id="customers_customers_customer_first_name" class="form-control"></td>';
      html += '<td><input type="text" name="customers[customers][]customer[phone]" id="customers_customers_customer_phone" class="form-control"></td>';
      html += '<td><select name="customers[customers][]customer[gender]" id="customers_customers_customer_gender" class="form-control"><option value="">Select</option><option value="false">Nữ</option><option value="true">Nam</option></select></td>';
      html += '<td><input type="date" name="customers[customers][]customer[birthday]" id="customers_customers_customer_birthday" class="form-control"></td></tr>';
    }

    $('#multi-customer tbody').append(html);
  });

  // Show/hide school or merchandise follow product selection in normal prospect form
  $('#customer_product_id').change(function(){
    if($(this).val() === '1'){
      $('#school-field').removeClass('hidden');
      $('#school-field').addClass('present');
      $('#merchandise-field').addClass('hidden');
      $('#merchandise-field').removeClass('present');
    }else if($(this).val() === '2'){
      $('#merchandise-field').removeClass('hidden');
      $('#merchandise-field').addClass('present');
      $('#school-field').addClass('hidden');
      $('#school-field').removeClass('present');
    }
  });

  // Show/hide school or merchandise follow product selection in list prospect form
  $('#customers_product_id').change(function(){
    if($(this).val() === '1'){
      $('.th-school').removeClass('hidden');
      $('.th-school').addClass('present');
      $('.th-merchandise').removeClass('present');
      $('.th-merchandise').addClass('hidden');

      $('.td-school').removeClass('hidden');
      $('.td-school').addClass('present');
      $('.td-merchandise').removeClass('present');
      $('.td-merchandise').addClass('hidden');
    }else if($(this).val() === '2'){
      $('.th-merchandise').removeClass('hidden');
      $('.th-merchandise').addClass('present');
      $('.th-school').removeClass('present');
      $('.th-school').addClass('hidden');

      $('.td-merchandise').removeClass('hidden');
      $('.td-merchandise').addClass('present');
      $('.td-school').removeClass('present');
      $('.td-school').addClass('hidden');
    }
  });
});