class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comments
      t.boolean :score
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
