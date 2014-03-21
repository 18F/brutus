class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :imports

      t.timestamps
    end
  end
end
