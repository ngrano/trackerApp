class CreateLocationRequests < ActiveRecord::Migration
  def self.up
    create_table :location_requests do |t|
      t.integer :user_id
      t.integer :friend_id
      t.datetime :created_at

      t.timestamps
    end

    add_index :location_requests, [:user_id, :friend_id], :unique => true
  end

  def self.down
    drop_table :location_requests
  end
end
