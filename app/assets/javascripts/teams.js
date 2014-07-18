$(document).ready( function() {

  //Pull subteam containers down
  $('.subteam-container').hide();
  $('.users-container').hide();
  $('.subteam-toggle').click(function() { 
    $(this).closest('.team-container').find('.subteam-container').animate({
      height: 'toggle'
    }, 500);
    $(this).toggleClass('fa-chevron-up fa-chevron-down'); 
  });

  //Pull subteam description left, reveal users
  $('.subteam-users-toggle').click(function() {
    var subteamContainer = $(this).closest('.individual-subteam-container');
    var userContainer = $(this).closest('.subteam-row').find('.users-container');
    console.log(subteamContainer);
    if($(this).hasClass('fa-chevron-right')) {
      subteamContainer.animate({
        width: '50%'
      }, 500, function() {
        userContainer.show();
      });
      $(this).toggleClass('fa-chevron-right fa-chevron-left');
    } else {
      userContainer.hide();
      subteamContainer.animate({
        width: '100%'
      }, 500);
      $(this).toggleClass('fa-chevron-right fa-chevron-left');
    }
  });
});