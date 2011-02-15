class RemoveUserIdIndex < ActiveRecord::Migration
  def self.up
    remove_index :locations, :user_id
    add_index :locations, :user_id
  end

  def self.down
    remove_index :locations, :user_id
    add_index :locations, :user_id, :unique => true
  end
end
