class PubKey < ActiveRecord::Base
  validate :name, :value, presence: true, uniqueness: :true
  belongs_to :student, foreign_key: 'user_id'
  has_many :repositories, through: :student

  delegate :username, to: :student

  after_create :add_key_to_gitosis, :update_repos
  after_destroy :rm_key_from_gitosis, :update_repos

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
end
