class RenameColumnImageInTableCocktails < ActiveRecord::Migration[6.0]
  def change
    rename_column :cocktails, :imgage, :image
  end
end
