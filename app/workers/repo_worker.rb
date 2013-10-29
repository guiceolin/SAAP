class RepoWorker
  include Sidekiq::Worker

  private
  def admin_repo
    @admin_repo ||= Gitolite::GitoliteAdmin.new('tmp/gitolite-admin')
  end

  def admin_config
    @config ||= admin_repo.config
  end

  def add_repo_to_gitolite(repo)
    admin_config.add_repo(repo)
    admin_repo.save_and_apply
  end
end
