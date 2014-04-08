class CreateCreditingPlans < ActiveRecord::Migration
  def change
    create_table :crediting_plans do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
