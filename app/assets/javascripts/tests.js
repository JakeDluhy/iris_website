$(document).ready( function() {

  $('.add-objective').click(function() {
    $('.objectives-container').toggleClass('active');
    $('.create-objective').toggleClass('active');
    $('.add-objective').find('.fa').toggleClass('fa-plus');
    $('.add-objective').find('.fa').toggleClass('fa-arrow-right');
  });

  $('.add-button').click(function(event) {
    event.preventDefault();
    var instructionForm = $('#new_test_objective');
    var data = instructionForm.serializeArray();

    $.ajax({
      url: instructionForm.prop('action'),
      type: 'POST',
      data: data,
      dataType: 'json',
      success: function(data, status, xhr) {
        $('.test-objective').val('');
        $('.expected-result').val('');
        $('.response').text('Objective created successfully!');
        $('.response-container').toggleClass('visible');
        $('.response-container').toggleClass('success');
        setTimeout(function() {
          $('.response').text('');
          $('.response-container').removeClass("visible");
          $('.response-container').removeClass('success');
        }, 3000);
      },
      error: function(xhr, status, error) {
        $('.test-objective').val('');
        $('.expected-result').val('');
        $('.response').text('Objective not created.');
        $('.response-container').toggleClass('visible');
        $('.response-container').toggleClass('error');
        setTimeout(function() {
          $('.response').text('');
          $('.response-container').removeClass("visible");
          $('.response-container').removeClass('error');
        }, 3000);
      }
    });
  });

  $('.completion-status').click(function(event) {
    $(this).closest('.display-item-card').find('.complete-content').animate({
      height: 'toggle'
    }, 500);
  });

  $('#test_comment_comment').keypress(function(e){
    var commentsContainer = $(event.target).closest('.comments-container').find('.comments');
    if(e.which == 13){//Enter key pressed
      var commentForm = $(this).closest('#new_test_comment');//Trigger search button click event
      var data = commentForm.serializeArray();
      $.ajax({
        url: commentForm.prop('action'),
        type: 'POST',
        data: data,
        dataType: 'json',
        success: function(data, status, xhr) {
          var html = JST['templates/comment'](data);
          commentsContainer.append(html);
          $('#test_comment_comment').val('');
        },
        error: function(xhr, status, error) {
          
        }
      });
      return false;
    }
  });

  $('.user-name.signup').click(function(){
    $(event.target).parent().find('#new_test_assignment').submit();//Trigger search button click event
  });
  $('.user-name.signup:first-child').click(function(){
    $(event.target).parent().parent().find('#new_test_assignment').submit();//Trigger search button click event
  });

  $('.complete-counter.active').click(function() {
    $('.display-item-card.incomplete').slideUp(500);
    $('.display-item-card.completed').slideDown(500);
  });
  $('.incomplete-counter.active').click(function() {
    $('.display-item-card.completed').slideUp(500);
    $('.display-item-card.incomplete').slideDown(500);
  });

  //Pull subteam containers down

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