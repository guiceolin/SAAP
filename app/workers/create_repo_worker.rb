class CreateRepoWorker < RepoWorker
  attr_accessor :group

  def perform(group_id)
    self.group = Group.find(group_id)
    repo = Gitolite::Config::Repo.new(generate_repo_name)
    repo.add_permission("RW+", "", *group_key_names)
    admin_config.add_repo(repo)
    admin_repo.save_and_apply
  end

  private

  def generate_repo_name
    "#{group.enunciation_name.gsub(/\s+/, '-')}-#{group.name.gsub(/\s+/, '-')}-#{Time.now.to_i}"
  end

  def group_key_names
    group.students_key_names
  end
end
