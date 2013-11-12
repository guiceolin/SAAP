class FinalRepoVersion < RepoVersion
  def oldfy
    self.type = "OldRepoVersion"
    self.save!
  end
end
