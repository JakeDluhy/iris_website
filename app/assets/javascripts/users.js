$(document).ready( function() {

  var teamForm = $('#join_teams');

  teamForm.on('submit', function(e) {
    $.ajax({
      url: teamForm.prop('action'),
      type: 'PUT',
      data: teamForm.serializeArray(),
      dataType: teamForm.data('type') || 'json',
      success: function(data, status, xhr) {
        console.log(data);
      },
      error: function(xhr, status, error) {
        console.log(status);
      }
    });

    return false;
  });

  $('.add-teams-container').hide();
  $('.join-teams-toggle').click(function() { 
    $(this).closest('.team-memberships').find('.add-teams-container').animate({
      height: 'toggle'
    }, 500);
    $(this).toggleClass('fa-chevron-up fa-chevron-down'); 
  });
});

