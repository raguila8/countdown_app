$(document).on('turbolinks:load', function() {  
  
  if ($(".countdown-date-element").length) {
    $dates = $(".countdown-date-element");
    console.log($dates.length);
    for (var i = 0; i < $dates.length; i++) {
      console.log(i);
      var clock;

      // Grab the current date
      var currentDate = new Date();

      // Set some date in the future. In this case, it's always Jan 1
      var futureDate  = new Date($dates[i].value);

      // Calculate the difference in seconds between the future and current date
      var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

      var date_id = $($dates[i]).attr('id');
      var id = parseInt(date_id.substring(5, date_id.length));
      // Instantiate a coutdown FlipClock
	    clock = $("#clock-" + id).FlipClock(diff, {
        clockFace: 'DailyCounter',
        countdown: true
      });

    }
  }

  $('.countdown-flickity').flickity( {
    // options
    cellAlign: 'left',
    wrapAround: true,
    pageDots: false
  });


});
