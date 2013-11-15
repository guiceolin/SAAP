class AddAcceptsAfterDeadlineToEnunciation < ActiveRecord::Migration
  def change
    add_column :enunciations, :accepts_after_deadline, :boolean, default: false
  end
end
