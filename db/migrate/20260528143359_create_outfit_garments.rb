class CreateOutfitGarments < ActiveRecord::Migration[8.1]
  def change
    create_table :outfit_garments do |t|
      t.references :outfit, null: false, foreign_key: true
      t.references :garment, null: false, foreign_key: true

      t.timestamps
    end
    add_index :outfit_garments, [:outfit_id, :garment_id], unique: true,
              name: "index_outfit_garments_on_outfit_and_garment"
  end
end
