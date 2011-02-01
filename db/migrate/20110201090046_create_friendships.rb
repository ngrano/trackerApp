class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :approved

      t.timestamps
    end

    add_index :friendships, [:user_id, :friend_id], :unique => true
  end

  def self.down
    drop_table :friendships
  end
end
