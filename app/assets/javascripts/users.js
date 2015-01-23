$(document).ready( function() {
  $(document).on('change', '.btn-file :file', function() {
    var display = $('.resume-feedback');
    var label = $(this).val().replace(/\\/g, '/').replace(/.*\//, '');
    display.html(label);
  });
});

