$(function () {
  (function fastProspectForm() {
    // Multi prospect form vars
    let $thSchool = $('.th-school');
    let $thMerchandise = $('.th-merchandise');
    let $addMoreBtn = $('#add-more');
    let $productId = $('#people_product_id');

    // Event add more 10 rows in create list prospect
    $addMoreBtn.click(function (e) {
      e.preventDefault();
      var productId = $productId.val();
      if(productId == ''){
        alert('Xin hãy chọn loại sản phẩm');
        return false;
      }

      lastRow = parseInt($('#multi-person tr:last').attr('id'));
      iNum = 100 - lastRow;
      currentRow = iNum < 10 ? iNum : 10;
      html = ''
      var schoolClass = productId === '1' ? 'present' : 'hidden';
      var merchandiseClass = productId === '2' ? 'present' : 'hidden';

      for (i = lastRow + 1; i <= lastRow + currentRow; i++) {
        html += '<tr id="' + i + '">';
        html += '<td><label class="control-label col-sm-3" for="stt">' + i + '</label></td>';
        html += '<td><input type="text" name="people[people][]person[last_name]" id="people_people_person_last_name" class="form-control"></td>';
        html += '<td><input type="text" name="people[people][]person[first_name]" id="people_people_person_first_name" class="form-control"></td>';
        html += '<td><input type="text" name="people[people][]person[phone]" id="people_people_person_phone" class="form-control"></td>';
        html += '<td class="td-school ' + schoolClass + '"><input type="text" name="people[people][]person[school]" id="people_people_person_school" class="form-control"></td>';
        html += '<td class="td-merchandise ' + merchandiseClass + '"><input type="text" name="people[people][]person[merchandise]" id="people_people_person_merchandise" class="form-control"></td>';
        html += '<td><input type="text" name="people[people][]person[nic_number]" id="people_people_person_nic_number" class="form-control"></td>';
        html += '<td><select name="people[people][]person[gender]" id="people_people_person_gender" class="form-control"><option value="">Select</option><option value="false">Nữ</option><option value="true">Nam</option></select></td>';
        html += '<td><input type="date" name="people[people][]person[birthday]" id="people_people_person_birthday" class="form-control"></td></tr>';
      }

      $('#multi-person tbody').append(html);

      if(parseInt($('#multi-person tr:last').attr('id')) >= 100){
        $addMoreBtn.addClass('hidden');
      }
    });

    // Show/hide school or merchandise follow product selection in list prospect form
    $productId.change(function () {
      let $tdSchool = $('.td-school');
      let $tdMerchandise = $('.td-merchandise');

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
  })();
});