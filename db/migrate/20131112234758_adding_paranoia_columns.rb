class AddingParanoiaColumns < ActiveRecord::Migration
  def change
    add_column :enunciations, :deleted_at, :datetime
    add_column :groups, :deleted_at, :datetime
    add_column :tasks, :deleted_at, :datetime
    add_column :messages_topics, :deleted_at, :datetime
    add_column :repositories, :deleted_at, :datetime
    add_column :repo_versions, :deleted_at, :datetime
    add_column :gtasks, :deleted_at, :datetime
    add_column :attachments, :deleted_at, :datetime
    add_column :crowds, :deleted_at, :datetime
    add_column :enrollments, :deleted_at, :datetime
    add_column :memberships, :deleted_at, :datetime
    add_column :messages_messages, :deleted_at, :datetime
    add_column :messages_deliveries, :deleted_at, :datetime

  end
end
