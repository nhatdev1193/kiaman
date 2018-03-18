$(function () {
  (function normalProspectForm() {
    // Normal prospect form vars
    let $schoolField = $('#school-field'),
        $merchandiseField = $('#merchandise-field'),
        $productId = $('.form-control[name="person[product_id]"]');

    // Show/hide school or merchandise follow product selection in normal prospect form
    $productId.change(function () {
      let $t = $(this);

      if ($t.val().toString() === '1') {
        $schoolField.removeClass('hidden').addClass('present');
        $merchandiseField.removeClass('present').addClass('hidden');
      } else if ($t.val().toString() === '2') {
        $merchandiseField.removeClass('hidden').addClass('present');
        $schoolField.removeClass('present').addClass('hidden');
      }
    });
  })();
});