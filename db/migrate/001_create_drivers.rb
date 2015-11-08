class CreateDrivers < ActiveRecord::Migration
  def self.up
    create_table :drivers do |t|
      t.string :name
      t.integer :permit_number
      t.string :email
      t.string :photo
      t.timestamps
    end
  end

  def self.down
    drop_table :drivers
  end
end
