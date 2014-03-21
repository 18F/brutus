class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :score
      t.text :remarks
      t.boolean :follow_up

      t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :follow_up
  end
end
