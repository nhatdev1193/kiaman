$(function () {
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
