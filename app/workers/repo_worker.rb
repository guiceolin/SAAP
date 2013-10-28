class RepoWorker
  include Sidekiq::Worker

  private
  def admin_repo
    @admin_repo ||= Gitolite::GitoliteAdmin.new('tmp/gitolite-admin')
  end

  def admin_config
    @config ||= admin_repo.config
  end

end
