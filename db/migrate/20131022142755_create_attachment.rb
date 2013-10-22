class CreateAttachment < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :document
      t.belongs_to :attachable, polymorphic: true
    end
  end
end
