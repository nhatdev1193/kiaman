$(function () {
  // Normal prospect form vars
  let $schoolField = $('#school-field');
  let $merchandiseField = $('#merchandise-field');

  // Multi prospect form vars
  let $thSchool = $('.th-school');
  let $thMerchandise = $('.th-merchandise');
  let $tdSchool = $('.td-school');
  let $tdMerchandise = $('.td-merchandise');

  // Event add more 10 rows in create list prospect
  $('#add-more').click(function (e) {
    e.preventDefault();
    lastRow = parseInt($('#multi-person tr:last').attr('id')) + 1;
    html = ''
    for (i = lastRow; i < lastRow + 10; i++) {
      html += '<tr id="' + i + '">';
      html += '<td><label class="control-label col-sm-3" for="stt">' + i + '</label></td>';
      html += '<td><input type="text" name="people[people][]person[last_name]" id="people_people_person_last_name" class="form-control"></td>';
      html += '<td><input type="text" name="people[people][]person[first_name]" id="people_people_person_first_name" class="form-control"></td>';
      html += '<td><input type="text" name="people[people][]person[phone]" id="people_people_person_phone" class="form-control"></td>';
      html += '<td><select name="people[people][]person[gender]" id="people_people_person_gender" class="form-control"><option value="">Select</option><option value="false">Nữ</option><option value="true">Nam</option></select></td>';
      html += '<td><input type="date" name="people[people][]person[birthday]" id="people_people_person_birthday" class="form-control"></td></tr>';
    }

    $('#multi-person tbody').append(html);
  });

  // Show/hide school or merchandise follow product selection in normal prospect form
  $('#person_product_id').change(function () {
    if ($(this).val() === '1') {
      $schoolField.removeClass('hidden').addClass('present');
      $merchandiseField.removeClass('present').addClass('hidden');
    } else if ($(this).val() === '2') {
      $merchandiseField.removeClass('hidden').addClass('present');
      $schoolField.removeClass('present').addClass('hidden');
    }
  });

  // Show/hide school or merchandise follow product selection in list prospect form
  $('#people_product_id').change(function () {
    if ($(this).val() === '1') {
      $thSchool.removeClass('hidden').addClass('present');
      $thMerchandise.removeClass('present').addClass('hidden');

      $tdSchool.removeClass('hidden').addClass('present');
      $tdMerchandise.removeClass('present').addClass('hidden');
    } else if ($(this).val() === '2') {
      $thMerchandise.removeClass('hidden').addClass('present');
      $thSchool.removeClass('present').addClass('hidden');

      $tdMerchandise.removeClass('hidden').addClass('present');
      $tdSchool.removeClass('present').addClass('hidden');
    }
  });

  $('#form_values_8').on('change', function() {
    $.get({
      url: '/staff/venues/districts?city_id=' + this.value
    }).success(function(data){
      $form_values_9 = $('#form_values_9');
      $form_values_9.find('option').remove().end();
      for(var id in data){
        $form_values_9.append(new Option(id, data[id]));
      }
      $('#form_values_9').prop("disabled", false);
    });
  });

  $('#form_values_9').on('change', function() {
    $.get({
      url: '/staff/venues/wards?district_id=' + this.value
    }).success(function(data){
      $form_values_10 = $('#form_values_10');
      $form_values_10.find('option').remove().end();
      for(var id in data){
        $form_values_10.append(new Option(id, data[id]));
      }
      $('#form_values_10').prop("disabled", false);
    });
  });
});