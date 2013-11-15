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

  def code(path, content)
    CodeRay.scan(content, convert_extension(path.split('/').last)).div(:line_numbers => :table).html_safe
  end

  def repo_version_label(repo_version)
    if repo_version.is_a? LateRepoVersion
      content_tag :span, I18n.t('git.tag.late_repo_version'), class: 'label label-danger'
    elsif repo_version.is_a? FinalRepoVersion
      content_tag :span, I18n.t('git.tag.final_repo_version'), class: 'label label-success'
    elsif repo_version.is_a? OldRepoVersion
      content_tag :span, I18n.t('git.tag.old_repo_version'), class: 'label label-warning'
    else
      content_tag :span, I18n.t('git.tag.partial_repo_version'), class: 'label label-info'
    end
  end

  private

  def convert_extension(file_name)
    if file_name =~ /(\.rb|\.ru|\.rake|Rakefile|\.gemspec|\.rbx|Gemfile)$/
      :ruby
    elsif file_name =~ /\.py$/
      :python
    elsif file_name =~ /(\.pl|\.scala|\.c|\.cpp|\.java|\.haml|\.html|\.sass|\.scss|\.xml|\.php|\.erb)$/
      $1[1..-1].to_sym
    elsif file_name =~ /\.js$/
      :javascript
    elsif file_name =~ /\.sh$/
      :bash
    elsif file_name =~ /\.coffee$/
      :coffeescript
    elsif file_name =~ /\.yml$/
      :yaml
    elsif file_name =~ /\.md$/
      :minid
    else
      :text
    end
  end
end
