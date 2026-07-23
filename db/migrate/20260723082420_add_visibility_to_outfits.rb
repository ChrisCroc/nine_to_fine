class AddVisibilityToOutfits < ActiveRecord::Migration[8.1]
  def change
    add_column :outfits, :visibility, :integer, default: 0, null: false
  end
end
