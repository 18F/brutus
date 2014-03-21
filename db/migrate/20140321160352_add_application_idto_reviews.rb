class AddApplicationIdtoReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :application_id, :integer
  end
end
