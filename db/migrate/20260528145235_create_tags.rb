class CreateTags < ActiveRecord::Migration[8.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tags, "user_id, LOWER(name)", unique: true,
              name: "index_tags_on_user_id_and_lower_name"
  end
end
