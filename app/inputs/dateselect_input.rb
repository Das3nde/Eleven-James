class DateselectInput < SimpleForm::Inputs::Base
  def input *args
    v = @builder.object[attribute_name]

    @builder.object[attribute_name] && @builder.object[attribute_name] = v.strftime('%m/%d/%Y')
    @builder.text_field(attribute_name, {type:'text'}).html_safe
  end
end