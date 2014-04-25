class AddSalesforceIdToApplications < ActiveRecord::Migration
  def change
  	add_column :applications, :salesforce_id, :text
  	add_index :applications, :salesforce_id
  end
end
