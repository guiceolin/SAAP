class Repository < ActiveRecord::Base
  validate :name, :url, presence: true
  belongs_to :group
  has_many :students, through: :group

  def update_repo
    if repo_exists?
      begin
        repo.pull
      rescue Git::GitExecuteError
        nil
      end
    else
      false
    end
  end

  def repo
    if repo_exists?
      @repo ||= Git.open(repo_path)
    else
      nil
    end
  end

  def tree(sha1 = 'HEAD')
    repo.gtree(sha1)
  end

  # Repo is initialized without any commits or branchs, even in origin
  def any_commits?
    begin
      repo && repo.log.last
    rescue Git::GitExecuteError
      false
    end
  end

  private

  def repo_path
    "tmp/#{name}"
  end

  def repo_exists?
    @repo_exists ||= File.exists? repo_path
  end

end
