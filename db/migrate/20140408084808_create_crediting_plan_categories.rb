class CreateCreditingPlanCategories < ActiveRecord::Migration
  def change
    create_table :crediting_plan_categories do |t|
      t.string :name
      t.text :description
      t.references :crediting_plan, index: true

      t.timestamps
    end
  end
end
