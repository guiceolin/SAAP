class RmKeyWorker < RepoWorker
  def perform(*key)
    key = Gitolite::SSHKey.from_string(*key)
    admin_repo.rm_key(key)
    admin_repo.save_and_apply
  end
end
