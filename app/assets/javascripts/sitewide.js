$(document).ready( function() {

  $('.file-input-wrapper').on('click', function(event) {
    console.log('here');
    event.stopImmediatePropagation();
    $('.file-input').trigger('click');
  });

  $('.file-input').on('change', function() {
    var files  = $('.file-input')[0].files;
    $('.file-input-preview').empty();
    for (var i = 0; i < files.length; i++) { //for multiple files          
      (function(file) {
        var reader  = new FileReader();
        reader.onloadend = function(e) {  
          var image = $('<img/>', { class: "preview img-rounded", src: reader.result, width: 60 });
          var wrappedImage = image.wrap('<div>').parent();
          $('.file-input-preview').append(wrappedImage);
        }
        reader.readAsDataURL(files[i]);
      })(files[i]);
    }
  });

  $(function() {
    $('a[href*=#]:not([href=#])').click(function() {
      if( $(this).attr("href")=="#outreach-carousel") return;//This is the exception
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html,body').animate({
            scrollTop: target.offset().top
          }, 1000);
          return false;
        }
      }
    });
  });
});