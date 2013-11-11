class PubKey < ActiveRecord::Base
  validate :name, :value, presence: true, uniqueness: :true
  belongs_to :student, foreign_key: 'user_id'
  has_many :repositories, through: :student

  delegate :username, to: :student

  after_create :add_key_to_gitosis, :update_repos, :log_creation
  after_destroy :rm_key_from_gitosis, :update_repos, :log_destruction

  private

  def update_repos
    repositories.map(&:id).each do |id|
      UpdateRepoWorker.perform_async(id)
    end
  end

  def rm_key_from_gitosis
    RmKeyWorker.perform_async(value, username, name)
  end

  def add_key_to_gitosis
    AddKeyWorker.perform_async(value, username, name)
  end

  def log_creation
    ActivityLog.create!(user: student,
                       item: self,
                       action: 'pub_key_creation',
                       serialized_object: self,
                       occurred_at: Time.current)
  end

  def log_destruction
    ActivityLog.create!(user: student,
                       item: self,
                       action: 'pub_key_destruction',
                       serialized_object: self,
                       occurred_at: Time.current)
  end
end
