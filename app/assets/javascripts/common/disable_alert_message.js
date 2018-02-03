var disableMessage = function () {
  setTimeout(function(){
    $('.alert-success').fadeOut('slow');
  }, 5000);
};
document.addEventListener('turbolinks:load', disableMessage);