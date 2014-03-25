class AddRemoteSourceToImports < ActiveRecord::Migration
  def change
  	add_column :imports, :remote_source, :string
  end
end
