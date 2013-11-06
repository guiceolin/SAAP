class AddReprovedToMessagesTopic < ActiveRecord::Migration
  def change
    add_column :messages_topics, :reproved, :boolean, default: false
  end
end
