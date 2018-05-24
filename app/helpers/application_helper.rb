module ApplicationHelper
  def flash_messages
    if flash[:notice] || flash[:success]
      type = "success"
      msg = flash[:notice] ? flash[:notice] : flash[:success]
    elsif flash[:alert]
      type = "warning"
      msg = flash[:alert]
    else
      return
    end
    html = "<div class='flash-message text-center'>\n"
    html += "  <div class='flash-message-overlay #{type} text-center'>\n"
    html += %Q{    <span class='text-center'><img class='inline-icon g-mr-5' \
      src='/#{type}.png'> #{msg} </span>\n  </div>\n</div>}
    return html.html_safe
  end

  def set_edit_profile_class
    ((controller_name == "users") && (action_name == "edit" || action_name == "update")) ? "active-effect-4" : "non-active-effect-4"
  end

  def set_edit_account_class
    ((devise_controller?) && (action_name == "update" || action_name == "edit")) ? "active-effect-4" : "non-active-effect-4" 
  end

  def landing_page?
    controller_name == 'static_pages' && action_name == 'landing'
  end

  def about_page?
    controller_name == 'static_pages' && action_name == 'about'
  end
end
