class AddFlaggedToApplications < ActiveRecord::Migration
  def change
  	add_column :applications, :flagged, :boolean
  end
end
