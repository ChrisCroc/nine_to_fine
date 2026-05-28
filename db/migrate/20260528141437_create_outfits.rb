class CreateOutfits < ActiveRecord::Migration[8.1]
  def change
    create_table :outfits do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :outfits, "user_id, LOWER(name)", unique: true,
              name: "index_outfits_on_user_id_and_lower_name"
  end
end
