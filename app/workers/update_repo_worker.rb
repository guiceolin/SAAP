class UpdateRepoWorker < RepoWorker

  attr_accessor :repository, :group

  def perform(repository_id)
    repo = find_repo(repository_id)
    update_permissions(repo)
    add_repo_to_gitolite(repo)
  end

  private
  def find_repo(id)
    self.repository = Repository.find(id)
    admin_config.get_repo(self.repository.name)
  end

  def update_permissions(repo)
    repo.clean_permissions
    repo.add_permission('RW+', "", self.repository.group.students_key_names << GITOLITE['admin_key_name'])
  end

end
