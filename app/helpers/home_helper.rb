module HomeHelper

  def sanitize_filter_class(value)
    value.gsub(" ", "-").downcase
  end

end
