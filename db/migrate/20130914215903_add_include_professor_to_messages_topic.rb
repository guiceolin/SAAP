class AddIncludeProfessorToMessagesTopic < ActiveRecord::Migration
  def change
    add_column :messages_topics, :include_professor, :boolean, default: true
  end
end
