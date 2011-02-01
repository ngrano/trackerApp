class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :user_id
      t.decimal :longtitude, :precision => 15, :scale => 10
      t.decimal :latitude, :precision => 15, :scale => 10
      t.datetime :created_at

      t.timestamps
    end

    add_index :locations, :user_id, :unique => true
  end

  def self.down
    drop_table :locations
  end
end
