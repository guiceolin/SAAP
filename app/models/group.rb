class Group < ActiveRecord::Base
  require 'soft_destroy'
  include SoftDestroy
  belongs_to :enunciation
  has_many :memberships, dependent: :destroy
  has_many :students, through: :memberships
  has_many :topics, class_name: 'Messages::Topic', as: :circle, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_one :repository, dependent: :destroy
  has_many :repo_versions, dependent: :destroy

  after_create :create_repo
  after_update :update_repo

  delegate :subject, :crowd, :professor, to: :enunciation

  def need_approvation?
    false
  end

  def enunciation_name
    enunciation.name
  end

  def students_key_names
    students.map(&:username)
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

  def parent_tasks
    @parent_tasks ||= tasks.where(parent_id: nil).group_by(&:status)
  end

  def not_started_tasks
    parent_tasks[:high] || []
  end

  def started_tasks
    parent_tasks[:medium] || []
  end

  def complete_tasks
    parent_tasks[:low] || []
  end

  def oldfy_versions
    repo_versions.where(type: 'FinalRepoVersion').map(&:oldfy)
  end

  private
  def create_repo
    CreateRepoWorker.perform_async(self.id)
  end

  def update_repo
    UpdateRepoWorker.perform_async(repository.id)
  end
end
