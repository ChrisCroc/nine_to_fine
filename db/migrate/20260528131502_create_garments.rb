class CreateGarments < ActiveRecord::Migration[8.1]
  def change
    create_table :garments do |t|
      t.string :name, null: false
      t.text :description
      t.string :color, null: false
      t.string :brand
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
