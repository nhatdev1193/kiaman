// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require font_awesome5
//= require lodash
//= require bootstrap/dist/js/bootstrap.js
//= require fastclick/lib/fastclick.js
//= require select2/dist/js/select2.full.js
//= require admin-lte/plugins/iCheck/icheck.js
//= require slimscroll/example/ssmaster/jquery.slimscroll.min.js
//= require admin-lte/dist/js/adminlte.min.js
//= require blueimp-file-upload/js/vendor/jquery.ui.widget.js
//= require blueimp-file-upload/js/jquery.iframe-transport.js
//= require blueimp-file-upload/js/jquery.fileupload.js
//= require lightgallery/dist/js/lightgallery-all.js
//= require_tree ./common
//= require_tree ./staff

$(function () {
  $('.select2').select2({ width: '100%' });

  // Flat red color scheme for iCheck
  $('input[type="checkbox"].i-check, input[type="radio"].i-check').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass   : 'iradio_square-green'
  });

  // Changing per page
  $('.will_paginate_per_page').change(function () {
    let $t = $(this);
    window.location.href = replaceUrlParam(window.location.toString(), 'per_page', $t.val());
  });
});