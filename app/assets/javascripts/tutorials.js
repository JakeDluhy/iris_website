$(document).ready( function() {

  var form = $('#new_tutorial');
  var instructionForm = $('#new_instruction');

  instructionForm.on('submit', function(e) {
    var data = instructionForm.serializeArray();
    // Need to find out how to get the value of a file input
    // data.push({
    //   name: 'instruction[pictures]',
    //   value: 
    // });
    $.ajax({
      url: instructionForm.prop('action'),
      type: instructionForm.prop('method') || 'POST',
      data: data,
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