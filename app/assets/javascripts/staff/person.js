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

  let venueSelectIds = [[8, 9, 10], [12, 13, 14], [61, 62, 63], [65, 66, 67], ['127', '128', '129']];
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
    $form_values_67: $('#form_values_67'),
    $form_values_127: $('#form_values_127'),
    $form_values_128: $('#form_values_128'),
    $form_values_129: $('#form_values_129')
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
