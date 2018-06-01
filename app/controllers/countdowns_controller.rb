class CountdownsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def create
    if params[:commit] == "Preview"
      
    end
    redirect_to user_path(current_user.id)
  end

  def destroy
  end

  def new
    @countdown = Countdown.new
  end

  def next
    respond_to do |format|
      @countdown = Countdown.new(countdown_params)
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
