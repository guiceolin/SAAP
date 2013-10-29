class ChangePubKeyValueToText < ActiveRecord::Migration
  def change
    change_column :pub_keys, :value, :text
  end
end
