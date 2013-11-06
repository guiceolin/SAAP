class AddGcalendarIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :gcalendar_id, :string
  end
end
