require 'zip'

class CountdownsController < ApplicationController
  def index
  end

  def show
    @countdown = Countdown.find(params[:id])

    respond_to do |format|
      format.html
      format.zip do
        compressed_filestream = Zip::OutputStream.write_buffer do |zos|
          zos.put_next_entry "countdown/image/main_image.jpg"
          zos.print File.open(File.join(Rails.root, "/public/#{@countdown.main_image.thumb.url}")).read

          zos.put_next_entry "countdown/image/background_image.jpg"
          zos.print File.open(File.join(Rails.root, "/public/#{@countdown.background_image.url}")).read

          zos.put_next_entry "countdown/css/countdown.css"
          zos.print File.open(File.join(Rails.root, "/public/countdown_zip/countdown.css")).read

          zos.put_next_entry "countdown/css/flipclock.css"
          zos.print File.open(File.join(Rails.root, "/public/countdown_zip/flipclock.css")).read

          zos.put_next_entry "countdown/js/countdown.js"
          zos.print File.open(File.join(Rails.root, "/public/countdown_zip/countdown.js")).read

          zos.put_next_entry "countdown/js/flipclock.js"
          zos.print File.open(File.join(Rails.root, "/public/countdown_zip/flipclock.js")).read

          zos.put_next_entry "countdown/index.html"
          zos.print @countdown.html_template
 
        end
        compressed_filestream.rewind
        send_data compressed_filestream.read, filename: "countdown.zip"

      end
    end
  end

  def edit
    @countdown = Countdown.find(params[:id])
  end

  def update
    @countdown = Countdown.find(params[:id])
    #@countdown = Countdown.new(countdown_params)
    @countdown.assign_attributes(countdown_params)
    if !params[:countdown][:local_main_image].empty?
      @countdown.main_image = File.open(File.join(Rails.root, "/public/#{params[:countdown][:local_main_image]}"))
    end

    if !params[:countdown][:local_background_image].empty?
      @countdown.background_image = File.open(File.join(Rails.root, "/public/#{params[:countdown][:local_background_image]}"))
    end

    if @countdown.save
      flash[:sucess] = "New Countdown Created!"
      redirect_to @countdown
    else
      render 'edit'
    end

  end

  def create
    @countdown = Countdown.new(countdown_params)
    if !params[:countdown][:local_main_image].empty?
      @countdown.main_image = File.open(File.join(Rails.root, "/public/#{params[:countdown][:local_main_image]}"))
    end

    if !params[:countdown][:local_background_image].empty?
      @countdown.background_image = File.open(File.join(Rails.root, "/public/#{params[:countdown][:local_background_image]}"))
    end

    @countdown.user = current_user
    if @countdown.save
      flash[:sucess] = "New Countdown Created!"
      redirect_to @countdown
    else
      render 'new'
    end
  end

  def destroy
    @countdown = Countdown.find(params[:id])
    @countdown.destroy
    redirect_to current_user
  end

  def new
    @countdown = Countdown.new
  end

  def next
    respond_to do |format|
      @countdown = Countdown.new(countdown_params)
      if !params[:countdown][:local_main_image].empty?
        @countdown.main_image = File.open(File.join(Rails.root, "/public/#{params[:countdown][:local_main_image]}"))

      end

      if !params[:countdown][:local_background_image].empty?
        @countdown.background_image = File.open(File.join(Rails.root, "/public/#{params[:countdown][:local_background_image]}"))
      end
 
      @countdown.user = current_user
      @valid = @countdown.valid?
      if @valid
        format.json {
          render json: { valid: @valid }
        }
      else
        format.json {
          render json: { valid: @valid, 
                         error: @countdown.errors.full_messages.first }
        }
      end
    end
  end

  def preview
    respond_to do |format|
      @countdown = Countdown.new(countdown_params)
      @countdown.user = current_user
      @valid = @countdown.valid?
      if @valid
        format.json {
          render json: { valid: @valid }
        }
      else
        format.json {
          render json: { valid: @valid, 
                         error: @countdown.errors.full_messages.first }
        }
      end
    end
   end

  private

    def countdown_params
      params.require(:countdown).permit(:countdown, :name, :date, :main_image, 
        :background_image, :title_color, :labels_color, 
        :clock_background_color, :time_color)
    end

end
