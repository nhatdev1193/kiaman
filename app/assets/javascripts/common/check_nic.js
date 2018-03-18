// Event check nic
$(function () {
  $('.btn-check-nic-number').click(function () {
    let $t = $(this),
        nicNumber = $('.form-control[name="person[nic_number]"]').val(),
        productId = $('.form-control[name="person[product_id]"]').val(),
        $nicMessage = $('#nic_message'),
        $form = $('#normal_prospect_form');

    if (!productId) {
      alert('Xin hãy chọn loại sản phẩm');
      return false;
    }

    $.ajax({
      url: '/staff/people/nic_check',
      type: 'post',
      data: {
        nic_number: nicNumber,
        product_id: productId
      },
      success: function (res) {
        if (parseInt(res.code) === 409) {
          $form.find(':submit').attr('disabled', true);
          $t.parents('.form-group').addClass('has-error');
        } else if (parseInt(res.code) === 200) {
          $form.find(':submit').attr('disabled', false);
          $t.parents('.form-group').addClass('has-success');
        }

        $nicMessage.html(res.message);
      }
    });
  });
});