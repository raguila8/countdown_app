$(document).on('ready turbolinks:load', function() {
	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
  
  $('.flash-message').slideDown(800);
  setTimeout(function(){
    $('.flash-message').slideUp(800, function() {
      $('.flash-message').remove();
    });
  }, 5000);
});
