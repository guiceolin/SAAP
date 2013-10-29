class Group < ActiveRecord::Base
  belongs_to :enunciation
  has_many :memberships
  has_many :students, through: :memberships
  has_many :topics, class_name: 'Messages::Topic', as: :circle
  has_one :repository, dependent: :destroy

  before_create :create_repo
  before_update :update_repo

  delegate :subject, :crowd, :professor, to: :enunciation

  def need_approvation?
    false
  end

  def enunciation_name
    enunciation.name
  end

  def students_key_names
    students.map { |s| { s => s.pub_keys } }.map do |hash|
      hash.values[0].map do |pub_key|
        "#{hash.keys[0].username}@#{pub_key.name}.pub"
      end
    end.flatten
  end

  def recipients
    students
  end

  def recipients_with_professor
    students + Array.wrap(professor)
  end

  def to_s
    "#{crowd} - #{enunciation} - #{name}"
  end

  private
  def create_repo
    CreateRepoWorker.perform_async(self.id)
  end

  def update_repo
    UpdateRepoWorker.perform_async(repository.id)
  end
end
