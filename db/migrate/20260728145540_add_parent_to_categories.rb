class AddParentToCategories < ActiveRecord::Migration[8.1]
  def change
    add_reference :categories, :parent,
                  foreign_key: { to_table: :categories }, null: true, index: true
  end
end
