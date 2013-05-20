module ApplicationHelper
  def determine_active_menu(context)
    case context
    when "home"
      "active" if action_name == "home"
    when "collection"
      "active" if action_name == "home"
    when "selection"
      "active" if action_name == "concierge" or action_name == "detail" or action_name == "listing" or action_name == "queue" or action_name == "signup"
    when "service"
      "active" if false
    when "news"
      "active" if false
    when "contact"
      "active" if action_name == "contact_us"
    else
      "active" if action_name == context
    end
  end
end
