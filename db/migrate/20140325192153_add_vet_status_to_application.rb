class AddVetStatusToApplication < ActiveRecord::Migration
  def change
  	add_column :applications, :vet_status, :text
  	add_index :applications, :vet_status
  end
end
