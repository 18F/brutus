class AddJunkToApplications < ActiveRecord::Migration
  def change
  	add_column :applications, :junk, :boolean, :default => :false
  end
end
