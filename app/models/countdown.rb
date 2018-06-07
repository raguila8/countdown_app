class Countdown < ApplicationRecord
  mount_uploader :main_image, CountdownMainImageUploader
  mount_uploader :background_image, CountdownBackgroundImageUploader

  belongs_to :user
  validates :name, presence: true, length: { maximum: 150 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  def date_format(format)
    date.strftime(format)
  end

  def html_template
    template = %(
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
          <meta name="description" content="">
          <meta name="author" content="">

          <title>#{name}</title>

          <!-- Bootstrap core CSS -->
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

          <!-- Custom styles for this template -->
          <link href="css/flipclock.css" rel="stylesheet">
          <link href="css/countdown.css" rel="stylesheet">

          <!-- Custom Javascript -->
          <script src='https://code.jquery.com/jquery-3.1.0.min.js'></script>
          <script src="js/flipclock.js"></script>
          <script src="js/countdown.js"></script>
        </head>
        <body>
          <div class="countdown" style="background: url('image/background_image.jpg')">
            <header class="masthead">
              <div class="intro-body">
                <div class="container">
                  <div class="text-center">
                    <h3 class="brand-heading margin" style="color: #{title_color}">#{name}</h3>
                    <img src="image/main_image.jpg"  class="img-responsive img-circle margin" alt="Me" style="display:inline" width="250" height="250">
                    <div class="text-center">
                      <div class="flip-counter clock flip-clock-wrapper" style=""></div>
                    </div>
                  </div>
                </div>
              </div>
            </header>
          </div>

          <input id="countdown-date" type="hidden" value="#{date}">
       
          <style>
            .flip-clock-label { 
              color: #{ labels_color } !important;
            }

            .flip-clock-wrapper ul li a div div.inn {
              color: #{ time_color } !important;
              background-color: #{ clock_background_color } !important;
            }
          </style>
        </body>
      </html>
    )
    return template
  end

  protected

    def date_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end
end
