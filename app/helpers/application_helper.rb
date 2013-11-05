module ApplicationHelper
  def magic_form_for(model, attributes)
    render 'shared/magic_form_for', model: model, attributes: attributes
  end

  def gravatar_url_for(user)
    md5 = Digest::MD5.hexdigest(current_user.email.strip.downcase)
    "http://www.gravatar.com/avatar/#{md5}?d=mm"
  end

  def repo_breadcrumb_for(group, tree, path)
    path ||= ""
    out = []
    out << link_to(group.name, group)
    out << link_to(tree, tree_group_path(group.id, tree: tree ))
    path.split('/').inject('') do |partial_path, part|
      partial_path = File.join(partial_path, part)
      out << link_to(part, tree_file_group_path(group, tree: tree, path: partial_path))
      partial_path
    end
    out.join(' / ').html_safe
  end
end
