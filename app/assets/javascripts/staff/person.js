$(function () {
  function loadVenues(dataType, parentId, destination, callBack = 0) {
    let venueParam = dataType == 'districts' ? 'city_id' : 'district_id';

    $.get({
      url: '/staff/venues/' + dataType + '?' + venueParam + '=' + parentId
    }).success(function (data) {
      destination.find('option').remove().end();
      for (let id in data) {
        destination.append(new Option(id, data[id]));
      }
      destination.prop("disabled", false);

      // Set option selected by value
      destination.val(destination.parent().data('value'));

      if (callBack) {
        callBack();
      }
    });
  }

  let venueSelectIds = [[8, 9, 10], [12, 13, 14], [89, 90, 91], [93, 94, 95], [183, 184, 185]];
  let venueGroup = {
    $form_values_8: $('#form_values_8'),
    $form_values_9: $('#form_values_9'),
    $form_values_10: $('#form_values_10'),
    $form_values_12: $('#form_values_12'),
    $form_values_13: $('#form_values_13'),
    $form_values_14: $('#form_values_14'),
    $form_values_89: $('#form_values_89'),
    $form_values_90: $('#form_values_90'),
    $form_values_91: $('#form_values_91'),
    $form_values_93: $('#form_values_93'),
    $form_values_94: $('#form_values_94'),
    $form_values_95: $('#form_values_95'),
    $form_values_183: $('#form_values_183'),
    $form_values_184: $('#form_values_184'),
    $form_values_185: $('#form_values_185')
  };

  venueSelectIds.forEach(function (group) {
    // On load
    loadVenues('districts', venueGroup["$form_values_" + group[0]].val(), venueGroup["$form_values_" + group[1]], function () {
      loadVenues('wards', venueGroup["$form_values_" + group[1]].val(), venueGroup["$form_values_" + group[2]]);
    });

    // On change
    venueGroup["$form_values_" + group[0]].bind("change", function () {
      loadVenues('districts', this.value, venueGroup["$form_values_" + group[1]]);
    });

    venueGroup["$form_values_" + group[1]].bind("change", function () {
      loadVenues('wards', this.value, venueGroup["$form_values_" + group[2]]);
    });
  });
});
