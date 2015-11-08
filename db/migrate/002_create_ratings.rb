class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :driver
      t.integer :quality
      t.string :comments
      t.string :suggestions
      t.boolean :delivered
      t.integer :status
      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
