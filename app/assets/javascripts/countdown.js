$(document).on('turbolinks:load', function() {
  var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  if ($("#countdown-modal").length) {
    $("#countdown-modal-link").animatedModal({
      modalTarget: 'countdown-modal'
    });
  }
/*
  if ($("#countdown-modal").length) {
    $("#previewBtn").animatedModal({
      modalTarget: 'countdown-modal'
    });
  });
*/

  if ($(".countdown-date-element").length) {
    $dates = $(".countdown-date-element");
    console.log($dates.length);
    for (var i = 0; i < $dates.length; i++) {
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
  if ($("#countdown-show").length) {
    var clock;

    // Grab the current date
    var currentDate = new Date();

    // Set some date in the future. In this case, it's always Jan 1
    var futureDate  = new Date($("#countdown-date").val());

    // Calculate the difference in seconds between the future and current date
    var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

    // Instantiate a coutdown FlipClock
	  clock = $('.clock').FlipClock(diff, {
      clockFace: 'DailyCounter',
      countdown: true
    });

  }

  if ($(".countdown-form").length) {
    $('.main-image-scroll').flickity( {
      // options
      cellAlign: 'left',
      wrapAround: true,
      pageDots: false
    });

    $('.background-image-scroll').flickity( {
      // options
      cellAlign: 'left',
      wrapAround: true,
      pageDots: false
    });

    var mainImageURL = "/main_images/main_image1.jpg";
    var backgroundImageURL = "/background_images/background_image1.jpg";

    var main_image_base64;
    var background_image_base64; 

    function getMainImageURL() {
      if (mainImageURL.length) {
        return mainImageURL;
      } else {
        return main_image_base64;
      }
    }

    function getBackgroundImageURL() {
      if (backgroundImageURL.length) {
        return backgroundImageURL;
      } else {
        return background_image_base64;
      }
    }

    var $mainImagePreview = $("#main-image-preview img");
    var $backgroundImagePreview = $("#background-image-preview img");

    $("body").on('click', '.main-image-scroll .default-image', function() {
      $mainImagePreview.attr("src", $(this).attr('src'));
      // set local_main_image input value
      $("#countdown_local_main_image").val($(this).attr('src'));
      //$("#countdown_main_image").val($(this)[0].src);
      mainImageURL = $(this).attr('src');
    });

    $("body").on('click', '.background-image-scroll .default-image', function() {
      $backgroundImagePreview.attr("src", $(this).attr('src'));
      // set local_background_image input value
      $("#countdown_local_background_image").val($(this).attr('src'));

      //$("#countdown_background_image").val($(this)[0].src);
      backgroundImageURL = $(this).attr('src');
    });


	  // Previews the image when user selects img file to submit
    $(".image-upload").change(function(event){
      var $current_input = $(this);
      var input = $(event.currentTarget);
      var file = input[0].files[0];
      var reader = new FileReader();
      reader.onload = function(e){
        image_base64 = e.target.result;
        if ($current_input.attr('id') == "countdown_main_image") {
          main_image_base64 = image_base64;
          mainImageURL = "";
          $("#countdown_local_main_image").val("");
          $mainImagePreview.attr("src", image_base64);
          //$("#countdown_main_image").val($current_input[0].files[0].path);
        } else {
          background_image_base64 = image_base64;
          backgroundImageURL = "";
          $("#countdown_local_background_image").val("");
          $backgroundImagePreview.attr("src", image_base64);
          //$("#countdown_background_image").val($current_input.val());
        }
      };
      reader.readAsDataURL(file);
	  });

    $('#countdown_title_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: $(this).val()
    });

    $('#countdown_title_color').show();

    $('#countdown_labels_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: $(this).val()
    });

    $('#countdown_labels_color').show();


    $('#countdown_time_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: $(this).val()
    });

    $('#countdown_time_color').show();


    $('#countdown_clock_background_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: $(this).val()
    });

    $('#countdown_clock_background_color').show();

    $('#preview-modal').modal({ show: false}) 
  
    $('body').on('click', '#previewBtn', function() {

      var i = 0;
      var parameters = new Map();

      var x = document.getElementsByTagName("input");
      //var x = document.getElementsByClassName("tab");
      for (j = 0; j < x.length; j++) {
        parameters.set(x[j].name, x[j].value)
      }

      $.ajax({
			  url: '/countdowns/new/preview',  // submits it to the given url of the form
				type: 'GET',
				data: {	
          countdown: {
					  name: parameters.get("countdown[name]"),
            date: parameters.get("countdown[date]"),
            main_image: parameters.get("countdown[main_image]"),
            background_image: parameters.get("countdown[background_image]"),
            title_color: parameters.get("countdown[title_color]"),
            labels_color: parameters.get("countdown[labels_color]"),
            clock_background_color: parameters.get("countdown[clock_background_color]"),
            time_color: parameters.get("countdown[time_color]")
          }
				},
        success: function(data) {
          $('#error_explanation').remove();
          valid = data.valid;
          if (!valid) {
            
            var html = "<div id='error_explanation'><ul><li>" + data.error + "</li></ul></div>";
            $('#regForm h1').after(html);
          } else {
            $('#preview-modal .countdown-modal-body').empty();
            var countdown_html = "<div class='countdown' style='background: url(" + getBackgroundImageURL() + ") no-repeat center center fixed;'>" +
              "<header class='masthead'><div class='intro-body'><div class='container col-md-12'><div class='text-center'>" + 
              "<h3 class='brand-heading margin g-mt-40' style=\"color:" +  parameters.get("countdown[title_color]") + ";\">" + parameters.get("countdown[name]") + "</h3>" + 
              "<img src=\"" + getMainImageURL() + "\"  class='img-fluid rounded-circle margin' alt='Me' style='display:inline' width='250' height='250'>" + 
              "<div class='flip-counter clock g-mb-40 flip-clock-wrapper'></div>" + 
             "</div></div></div></header></div>";
 

            $('#preview-modal .countdown-modal-body').append(countdown_html);
            
            var clock;

            // Grab the current date
            var currentDate = new Date();

            // Set some date in the future. In this case, it's always Jan 1
            var futureDate  = new Date(parameters.get("countdown[date]") + 'T00:00');

            // Calculate the difference in seconds between the future and current date
            var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

            // Instantiate a coutdown FlipClock
	          clock = $('.clock').FlipClock(diff, {
              clockFace: 'DailyCounter',
              countdown: true
            });


            if ($("#flipclock-stylesheet").length) {
              $("#flipclock-stylesheet").remove();
            }

            var sheet = document.createElement('style');
            sheet.id = "flipclock-stylesheet";
            sheet.innerHTML = ".flip-clock-label { color: " + 
              parameters.get("countdown[labels_color]") + 
              " !important;} .flip-clock-wrapper ul li a div div.inn { color: " + 
               parameters.get("countdown[time_color]") + 
               " !important; background-color: " + 
               parameters.get("countdown[clock_background_color]") + 
               " !important;}";
             document.body.appendChild(sheet);
            
             $("#preview-modal").modal("show");
          }

        }
			});
    });

  }

  if ($("#ct-edit-form").length) {
    
  }

  if ($('#regForm').length) { 
    function getBase64Image(img) {
      var canvas = document.createElement("canvas");
      canvas.width = img.width;
      canvas.height = img.height;
      var ctx = canvas.getContext("2d");
      ctx.drawImage(img, 0, 0);
      var dataURL = canvas.toDataURL("image/jpg");
      return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
    }
/*
    var mainImageURL = "/main_images/main_image1.jpg";
    var backgroundImageURL = "/background_images/background_image1.jpg";

    var main_image_base64;
    var background_image_base64; 
*/
/*    
    function getMainImageURL() {
      if (mainImageURL.length) {
        return mainImageURL;
      } else {
        return main_image_base64;
      }
    }

    function getBackgroundImageURL() {
      if (backgroundImageURL.length) {
        return backgroundImageURL;
      } else {
        return background_image_base64;
      }
    }


    var main_image_base64;
    var background_image_base64; 
*/
/*
    var $mainImagePreview = $("#main-image-preview img");
    var $backgroundImagePreview = $("#background-image-preview img");

    $("body").on('click', '.main-image-scroll .default-image', function() {
      $mainImagePreview.attr("src", $(this).attr('src'));
      // set local_main_image input value
      $("#countdown_local_main_image").val($(this).attr('src'));
      //$("#countdown_main_image").val($(this)[0].src);
      mainImageURL = $(this).attr('src');
    });

    $("body").on('click', '.background-image-scroll .default-image', function() {
      $backgroundImagePreview.attr("src", $(this).attr('src'));
      // set local_background_image input value
      $("#countdown_local_background_image").val($(this).attr('src'));

      //$("#countdown_background_image").val($(this)[0].src);
      backgroundImageURL = $(this).attr('src');
    });


	  // Previews the image when user selects img file to submit
    $(".image-upload").change(function(event){
      var $current_input = $(this);
      var input = $(event.currentTarget);
      var file = input[0].files[0];
      var reader = new FileReader();
      reader.onload = function(e){
        image_base64 = e.target.result;
        if ($current_input.attr('id') == "countdown_main_image") {
          main_image_base64 = image_base64;
          mainImageURL = "";
          $("#countdown_local_main_image").val("");
          $mainImagePreview.attr("src", image_base64);
          //$("#countdown_main_image").val($current_input[0].files[0].path);
        } else {
          background_image_base64 = image_base64;
          backgroundImageURL = "";
          $("#countdown_local_background_image").val("");
          $backgroundImagePreview.attr("src", image_base64);
          //$("#countdown_background_image").val($current_input.val());
        }
      };
      reader.readAsDataURL(file);
	  });
*/

    var currentTab = 0; // Current tab is set to be the first tab (0)
    showTab(currentTab); // Display the crurrent tab
    nextPrev();

    function showTab(n) {
      // This function will display the specified tab of the form...
      var x = document.getElementsByClassName("tab");
      x[n].style.display = "block";
      //... and fix the Previous/Next buttons:
      if (n == 0) {
        document.getElementById("prevBtn").style.display = "none";
        document.getElementById("previewBtn").style.display = "none";
      } else {
        document.getElementById("prevBtn").style.display = "inline";
        document.getElementById("previewBtn").style.display = "inline";
      }

      if (n == (x.length - 1)) {
        document.getElementById("nextBtn").innerHTML = "Submit";
        $('.main-image-scroll').flickity('resize');
        $('.background-image-scroll').flickity('resize');
      } else {
        document.getElementById("nextBtn").innerHTML = "Next <span class='glyphicon glyphicon-chevron-right'></span>";
      }
      //... and run a function that will display the correct step indicator:
      fixStepIndicator(n)
    }

    function nextPrev() {
      $("body").on("click", ".next-prev-btn", function() {
        var n = 1;
        if ($(this).attr('id') == "prevBtn") {
          n = -1;
        }
        // This function will figure out which tab to display
        var x = document.getElementsByClassName("tab");
        // Exit the function if any field in the current tab is invalid:
        //console.log(validateForm());
        if (n == 1 && !validateForm()) return false;
        // Hide the current tab:
        x[currentTab].style.display = "none";
        // Increase or decrease the current tab by 1:
        currentTab = currentTab + n;
        // if you have reached the end of the form...
        if (currentTab >= x.length) {
          // ... the form gets submitted:
          document.getElementById("regForm").submit();
          return false;
        }
        // Otherwise, display the correct tab:
        showTab(currentTab);
      });
    }

    function validateForm() {
      // This function deals with validation of the form fields
      var valid = false;
      var i = 0;
      var parameters = new Map();

      var x = document.getElementsByClassName("tab");
      for (i = 0; i < x.length; i++) {
        var y = x[i].getElementsByTagName("input");
        for (j = 0; j < y.length; j++) {
          parameters.set(y[j].name, y[j].value)
        }
      }

      $.ajax({
				url: '/countdowns/new/next',  // submits it to the given url of the form
				type: 'GET',
        async: false,
				data: {
          countdown: {
            local_main_image: $('#countdown_local_main_image').val(),
            local_background_image: $('#countdown_local_background_image').val(),
					  name: parameters.get("countdown[name]"),
            date: parameters.get("countdown[date]"),
            main_image: parameters.get("countdown[main_image]"),
            background_image: parameters.get("countdown[background_image]"),
            title_color: parameters.get("countdown[title_color]"),
            labels_color: parameters.get("countdown[labels_color]"),
            clock_background_color: parameters.get("countdown[clock_background_color]"),
            time_color: parameters.get("countdown[time_color]")
          }
				},
        success: function(data) {
          $('#error_explanation').remove();
          valid = data.valid;
          if (!valid) {
            var html = "<div id='error_explanation'><ul><li>" + data.error + "</li></ul></div>";
            $('#regForm h1').after(html);
          } else {
            document.getElementsByClassName("step")[currentTab].className += " finish";
          }
        }
			});

      return valid; // return the valid status
    }

    function fixStepIndicator(n) {
      // This function removes the "active" class of all steps...
      var i, x = document.getElementsByClassName("step");
      for (i = 0; i < x.length; i++) {
        x[i].className = x[i].className.replace(" active", "");
      }
      //... and adds the "active" class on the current step:
      x[n].className += " active";
    }
/*
    var main_image_base64;
    var background_image_base64;

    $("#countdown_main_image").change(function(event){
      var input = $(event.currentTarget);
      var file = input[0].files[0];
      var reader = new FileReader();
      reader.onload = function(e){
        main_image_base64 = e.target.result;
      };
      reader.readAsDataURL(file);
	  });

    $("#countdown_background_image").change(function(event){
      var input = $(event.currentTarget);
      var file = input[0].files[0];
      var reader = new FileReader();
      reader.onload = function(e){
        background_image_base64 = e.target.result;
      };
      reader.readAsDataURL(file);
	  });


    $("body").on("click", "#previewBtn", function() {
      var x = document.getElementsByClassName("tab");
      var parameters = new Map();
      for (i = 0; i < x.length; i++) {
        var y = x[i].getElementsByTagName("input");
        for (j = 0; j < y.length; j++) {
          parameters.set(y[j].name, y[j].value)
        }
      }

      
      var href = "/countdowns/new/preview?" + 
        "countdown[name]=" + parameters.get("countdown[name]") + "&" + 
        "countdown[date]=" + parameters.get("countdown[date]") + "&" + 
        "countdown[main_image]=" + parameters.get("countdown[main_image]") + "&" +
        "countdown[background_image]=" + parameters.get("countdown[background_image]") + "&" + 
        "countdown[title_color]=" + parameters.get("countdown[title_color]") + "&" + 
        "countdown[labels_color]=" + parameters.get("countdown[labels_color]") + "&" + 
        "countdown[clock_background_color]=" + parameters.get("countdown[clock_background_image]") + "&" +
        "countdown[time_color]=" + parameters.get("countdown[time_color]");

      var w = window.open(href);
*/
     /*
      var image = new Image();
      var input = $("#countdown_main_image");
      var file = input[0].files[0];
      if (file) {
        var reader = new FileReader();
        reader.onload = function(e){
          image_base64 = e.target.result;
          console.log(image_base64);
          image.src = ("src", image_base64);
        };
        reader.readAsDataURL(file);
      }
      $(w.document.body)[0].append(image);
      
    });*/

/*
    $('body').on('click', '#nextBtn', function(event) {
			var id = $(this).attr('id');
			var user_id = parseInt(id.substring(14, id.length));
			$("#following-btn-" + user_id).remove();
		
			$.ajax({
				url: '/unfollow',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'GET',
				data: {	
					authenticity_token: AUTH_TOKEN,
					followed: user_id
				}
			});
		});
*/
/*
    $('#countdown_title_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: "#ffffff"
    });

    $('#countdown_title_color').show();

    $('#countdown_labels_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: "#ffffff"
    });

    $('#countdown_labels_color').show();


    $('#countdown_time_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: "#cccccc"
    });

    $('#countdown_time_color').show();


    $('#countdown_clock_background_color').spectrum({
      preferredFormat: "hex",
      showInput: true,
      color: "#333333"
    });

    $('#countdown_clock_background_color').show();
*/
/*
    $('#preview-modal').modal({ show: false}) 
  
    $('body').on('click', '#previewBtn', function() {

      var i = 0;
      var parameters = new Map();

      var x = document.getElementsByClassName("tab");
      for (i = 0; i < x.length; i++) {
        var y = x[i].getElementsByTagName("input");
        for (j = 0; j < y.length; j++) {
          parameters.set(y[j].name, y[j].value)
        }
      }

      $.ajax({
			  url: '/countdowns/new/preview',  // submits it to the given url of the form
				type: 'GET',
				data: {	
          countdown: {
					  name: parameters.get("countdown[name]"),
            date: parameters.get("countdown[date]"),
            main_image: parameters.get("countdown[main_image]"),
            background_image: parameters.get("countdown[background_image]"),
            title_color: parameters.get("countdown[title_color]"),
            labels_color: parameters.get("countdown[labels_color]"),
            clock_background_color: parameters.get("countdown[clock_background_color]"),
            time_color: parameters.get("countdown[time_color]")
          }
				},
        success: function(data) {
          $('#error_explanation').remove();
          valid = data.valid;
          if (!valid) {
            
            var html = "<div id='error_explanation'><ul><li>" + data.error + "</li></ul></div>";
            $('#regForm h1').after(html);
          } else {
            $('#preview-modal .countdown-modal-body').empty();
            var countdown_html = "<div class='countdown' style='background: url(" + getBackgroundImageURL() + ") no-repeat center center fixed;'>" +
              "<header class='masthead'><div class='intro-body'><div class='container col-md-12'><div class='text-center'>" + 
              "<h3 class='brand-heading margin g-mt-40' style=\"color:" +  parameters.get("countdown[title_color]") + ";\">" + parameters.get("countdown[name]") + "</h3>" + 
              "<img src=\"" + getMainImageURL() + "\"  class='img-fluid rounded-circle margin' alt='Me' style='display:inline' width='250' height='250'>" + 
              "<div class='flip-counter clock g-mb-40 flip-clock-wrapper'></div>" + 
             "</div></div></div></header></div>";
 

            $('#preview-modal .countdown-modal-body').append(countdown_html);
            
            var clock;

            // Grab the current date
            var currentDate = new Date();

            // Set some date in the future. In this case, it's always Jan 1
            var futureDate  = new Date(parameters.get("countdown[date]") + 'T00:00');

            // Calculate the difference in seconds between the future and current date
            var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

            // Instantiate a coutdown FlipClock
	          clock = $('.clock').FlipClock(diff, {
              clockFace: 'DailyCounter',
              countdown: true
            });


            if ($("#flipclock-stylesheet").length) {
              $("#flipclock-stylesheet").remove();
            }

            var sheet = document.createElement('style');
            sheet.id = "flipclock-stylesheet";
            sheet.innerHTML = ".flip-clock-label { color: " + 
              parameters.get("countdown[labels_color]") + 
              " !important;} .flip-clock-wrapper ul li a div div.inn { color: " + 
               parameters.get("countdown[time_color]") + 
               " !important; background-color: " + 
               parameters.get("countdown[clock_background_color]") + 
               " !important;}";
             document.body.appendChild(sheet);
            
             $("#preview-modal").modal("show");
          }

        }
			});
    });
*/
  }
});
