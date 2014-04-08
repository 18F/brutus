class CreateCreditingPlanAssertions < ActiveRecord::Migration
  def change
    create_table :crediting_plan_assertions do |t|
      t.integer :score
      t.text :description
      t.references :crediting_plan_category, index: true

      t.timestamps
    end
  end
end
