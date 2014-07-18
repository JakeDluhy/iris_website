$(document).ready( function() {

  $('.file-input-wrapper').on('click', function(event) {
    event.stopImmediatePropagation();
    console.log('here');
    $('.file-input').trigger('click');
  });

  $('.file-input').on('change', function() {
    var files  = $('.file-input')[0].files;
    $('.file-input-preview').empty();
    console.log(files);
    for (var i = 0; i < files.length; i++) { //for multiple files          
      (function(file) {
        var reader  = new FileReader();
        reader.onloadend = function(e) {  
          var image = $('<img/>', { class: "preview img-rounded", src: reader.result, width: 60 });
          var wrappedImage = image.wrap('<div>').parent();
          console.log(image);
          $('.file-input-preview').append(wrappedImage);
        }
        reader.readAsDataURL(files[i]);
      })(files[i]);
    }
  });
});