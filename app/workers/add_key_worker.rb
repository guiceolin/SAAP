class AddKeyWorker < RepoWorker
  def perform(*key)
    key = Gitolite::SSHKey.from_string(*key)
    admin_repo.add_key(key)
    admin_repo.save_and_apply
  end
end
