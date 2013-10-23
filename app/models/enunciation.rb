class Enunciation < ActiveRecord::Base
  belongs_to :crowd

  validates :end_at, timeliness: { on_or_after: lambda { Date.today } }
  validates :name, :description, presence: true

  has_many :groups
  has_many :grouped_students, class_name: 'Student', through: :groups, source: :students
  has_many :students, through: :crowd
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true, reject_if: proc { |attributes| attributes['document'].blank? }

  delegate :professor, :subject, to: :crowd

  def ungrouped_students
    students - grouped_students
  end

  def clone_for_crowd(crowd_id)
    cloned = self.class.new(name: self.name + ' - Clone', description: self.description, end_at: 1.day.from_now )
    cloned.clone_attachments(self)
    cloned.clone_groups(self) if crowd_id.to_i == self.crowd_id
    cloned
  end

  def to_s
    name
  end

  def clone_groups(enum)
    enum.groups.each do |g|
      group = Group.create(name: g.name, enunciation: self)
      g.students.map { |s| group.students << s }
    end
  end

  def clone_attachments(enum)
    enum.attachments.each do |a|
      Attachment.create!(document: a.document, attachable: self)
    end
  end

end
