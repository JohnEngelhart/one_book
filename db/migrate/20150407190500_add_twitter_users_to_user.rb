class AddTwitterUsersToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitterUsers, :string
  end
end
