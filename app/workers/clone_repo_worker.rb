class CloneRepoWorker
  include Sidekiq::Worker

  def perform(url, name)
    grit = Grit::Git.new('tmp/' + name)
    grit.clone({}, url, 'tmp/' + name)
  end
end
