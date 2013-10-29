class PubKey < ActiveRecord::Base
  validate :name, :value, presence: true, uniqueness: :true
  belongs_to :user

  delegate :username, to: :user

  after_create :add_key_to_gitosis
  after_destroy :rm_key_from_gitosis

  private

  def rm_key_from_gitosis
    RmKeyWorker.perform_async(value, username, name)
  end

  def add_key_to_gitosis
    AddKeyWorker.perform_async(value, username, name)
  end
end
