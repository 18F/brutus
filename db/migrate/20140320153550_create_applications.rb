class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :remote_key
      t.string :remote_source
      t.string :status
      t.string :name

      t.timestamps
    end

    add_index :applications, :remote_key
    add_index :applications, :remote_source
    add_index :applications, :status
  end
end
