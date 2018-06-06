class CountdownsController < ApplicationController
  def index
  end

  def show
    @countdown = Countdown.find(params[:id])
  end

  def edit
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
