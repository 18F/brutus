class CreateSecondFactors < ActiveRecord::Migration
  def change
    create_table :second_factors do |t|
      t.string :encrypted_password
      t.boolean :active

      t.timestamps
    end
  end
end
