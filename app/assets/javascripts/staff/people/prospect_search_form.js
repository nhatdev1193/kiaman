$(function(){
  let formID = $('#prospect-seach-form');

  formID.find('select').change(function(){
    formID.submit();
  });

  formID.find('input[type=date]').change(function(){
    formID.submit();
  });
});