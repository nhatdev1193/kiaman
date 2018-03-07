$(document).on('turbolinks:load', function(){
  // Normal prospect form vars
  let $schoolField = $('#school-field');
  let $merchandiseField = $('#merchandise-field');

  // Multi prospect form vars
  let $thSchool = $('.th-school');
  let $thMerchandise = $('.th-merchandise');
  let $tdSchool = $('.td-school');
  let $tdMerchandise = $('.td-merchandise');

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
      $schoolField.removeClass('hidden').addClass('present');
      $merchandiseField.removeClass('present').addClass('hidden');
    }else if($(this).val() === '2'){
      $merchandiseField.removeClass('hidden').addClass('present');
      $schoolField.removeClass('present').addClass('hidden');
    }
  });

  // Show/hide school or merchandise follow product selection in list prospect form
  $('#customers_product_id').change(function(){
    if($(this).val() === '1'){
      $thSchool.removeClass('hidden').addClass('present');
      $thMerchandise.removeClass('present').addClass('hidden');

      $tdSchool.removeClass('hidden').addClass('present');
      $tdMerchandise.removeClass('present').addClass('hidden');
    }else if($(this).val() === '2'){
      $thMerchandise.removeClass('hidden').addClass('present');
      $thSchool.removeClass('present').addClass('hidden');

      $tdMerchandise.removeClass('hidden').addClass('present');
      $tdSchool.removeClass('present').addClass('hidden');
    }
  });
});