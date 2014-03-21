class ChangeAgencyToAgencyIdForUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :agency
  	add_column :users, :agency_id, :integer
  end
end
