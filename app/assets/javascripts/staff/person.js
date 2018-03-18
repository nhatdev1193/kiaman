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

  function loadVenues(dataType, parentId, destination, callBack = 0){
    let venueParam = dataType == 'districts' ? 'city_id' : 'district_id';

    $.get({
      url: '/staff/venues/' + dataType + '?' + venueParam + '=' + parentId
    }).success(function(data){
      destination.find('option').remove().end();
      for(var id in data){
        destination.append(new Option(id, data[id]));
      }
      destination.prop("disabled", false);

      // Set option selected by value
      destination.val(destination.parent().data('value'));

      if(callBack){
        callBack();
      }
    });
  }

  let venueSelectIds = [[8, 9, 10], [12, 13, 14], [61, 62, 63], [65, 66, 67]];
  let venueGroup = {
    $form_values_8: $('#form_values_8'),
    $form_values_9: $('#form_values_9'),
    $form_values_10: $('#form_values_10'),
    $form_values_12: $('#form_values_12'),
    $form_values_13: $('#form_values_13'),
    $form_values_14: $('#form_values_14'),
    $form_values_61: $('#form_values_61'),
    $form_values_62: $('#form_values_62'),
    $form_values_63: $('#form_values_63'),
    $form_values_65: $('#form_values_65'),
    $form_values_66: $('#form_values_66'),
    $form_values_67: $('#form_values_67')
  };

  venueSelectIds.forEach(function(group){
    // On load
    loadVenues('districts', venueGroup["$form_values_" + group[0]].val(), venueGroup["$form_values_" + group[1]], function(){
      loadVenues('wards', venueGroup["$form_values_" + group[1]].val(), venueGroup["$form_values_" + group[2]]);
    });

    // On change
    venueGroup["$form_values_" + group[0]].bind("change", function(){
      loadVenues('districts', this.value, venueGroup["$form_values_" + group[1]]);
    });

    venueGroup["$form_values_" + group[1]].bind("change", function(){
      loadVenues('wards', this.value, venueGroup["$form_values_" + group[2]]);
    });
  });
});
