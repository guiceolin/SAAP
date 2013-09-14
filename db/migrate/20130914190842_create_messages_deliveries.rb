class CreateMessagesDeliveries < ActiveRecord::Migration
  def change
    create_table :messages_deliveries do |t|
      t.references :message, index: true
      t.references :recipient, index: true
      t.boolean :readed, default: false

      t.timestamps
    end
  end
end
