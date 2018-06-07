$(document).ready(function() {
  var clock;

  // Grab the current date
  var currentDate = new Date();

  // Set some date in the future.
  var futureDate  = new Date($("#countdown-date").val());

  // Calculate the difference in seconds between the future and current date
  var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

  // Instantiate a coutdown FlipClock
  clock = $('.clock').FlipClock(diff, {
    clockFace: 'DailyCounter',
    countdown: true
  });
});
