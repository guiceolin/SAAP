class AddOauthFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :oauth_refresh_token, :string
    add_column :users, :oauth_access_token, :string
    add_column :users, :oauth_expires_in, :integer
  end
end
