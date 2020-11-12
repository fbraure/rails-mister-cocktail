class RenameNameToIngretient < ActiveRecord::Migration[6.0]
  def change
    rename_column :ingredients, :namme, :name
  end
end
