class CreateRepoWorker < RepoWorker
  attr_accessor :group

  def perform(group_id)
    self.group = Group.find(group_id)
    repo = create_repo
    add_repo_to_gitolite(repo)
    save_repo_name
  end

  private

  def create_repo
    repo = Gitolite::Config::Repo.new(generate_repo_name)
    repo.add_permission("RW+", "", *group_key_names)
    repo
  end

  def generate_repo_name
    @name ||= "#{group.enunciation_name.gsub(/\s+/, '-')}-#{group.name.gsub(/\s+/, '-')}-#{Time.now.to_i}"
  end

  def group_key_names
    group.students_key_names
  end

  def save_repo_name
    group.repository = Repository.create!( name: generate_repo_name, url: generate_repo_url )
  end

  def generate_repo_url
    @url ||= "#{GITOLITE['user']}@#{GITOLITE['domain']}:#{generate_repo_name}.git"
  end
end
