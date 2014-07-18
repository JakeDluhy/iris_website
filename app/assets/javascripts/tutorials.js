$(document).ready( function() {

  var form = $('#new_tutorial');
  var instructionForm = $('#new_instruction');

  instructionForm.on('submit', function(e) {
    $.ajax({
      url: instructionForm.prop('action'),
      type: instructionForm.prop('method') || 'POST',
      data: instructionForm.serializeArray(),
      dataType: instructionForm.data('type') || 'json',
      success: function(data, status, xhr) {
        var html = JST['templates/show_instruction'](data);
        $('.new-instruction').before(html);
        $('#instruction_title').val('');
        $('#instruction_content').val('');
        $('#instruction_order_id').val(data.order_id + 1);
      },
      error: function(xhr, status, error) {
        console.log(status);
      }
    });

    return false;
  });
});