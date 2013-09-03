module ApplicationHelper
  def magic_form_for(model, attributes)
    render 'shared/magic_form_for', model: model, attributes: attributes
  end

  def gravatar_url_for(user)
    md5 = Digest::MD5.hexdigest(current_user.email.strip.downcase)
    "http://www.gravatar.com/avatar/#{md5}"
  end
end
