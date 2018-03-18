// Event check nic
$(function () {
  $('.btn-check-nic-number').click(function () {
    let $t = $(this),
        nicNumber = $('#person_nic_number').val(),
        productId = $('#person_product_id').val(),
        $nicMessage = $('#nic-message'),
        $personForm = $('#new_person');

    if (!productId) {
      alert('Xin hãy chọn loại sản phẩm')
    } else {
      $.ajax({
        url: '/staff/people/nic_check',
        type: 'post',
        data: {
          nic_number: nicNumber,
          product_id: productId
        },
        success: function (res) {
          if (parseInt(res.code) === 409) {
            $personForm.find(':submit').attr('disabled', true);
            $t.parents('.form-group').addClass('has-error');
          } else if (parseInt(res.code) === 200) {
            $personForm.find(':submit').attr('disabled', false);
            $t.parents('.form-group').addClass('has-success');
          }

          $nicMessage.html(res.message);
        }
      })
    }
  });
});