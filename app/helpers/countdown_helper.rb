module CountdownHelper
  def params_valid?(countdown)
    countdown.assign_attributes(countdown_params)
    countdown.valid?
  end

  private

    def countdown_params
      params.require(:countdown).permit(:name, :date, :main_image, :background_image)
    end
end
