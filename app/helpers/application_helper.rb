module ApplicationHelper
  def magic_form_for(model, attributes)
    render 'shared/magic_form_for', model: model, attributes: attributes
  end
end
