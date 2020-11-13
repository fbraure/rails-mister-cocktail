class AddImgToCocktail < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :imgage, :string, default: "", null:
     false
  end
end
