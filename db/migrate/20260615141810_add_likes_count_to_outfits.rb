class AddLikesCountToOutfits < ActiveRecord::Migration[8.1]
  def change
    add_column :outfits, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up do
        execute <<~SQL.squish
          UPDATE outfits
          SET likes_count = (
            SELECT COUNT(*)
            FROM likes
            WHERE likes.likeable_type = 'Outfit'
              AND likes.likeable_id = outfits.id
          )
        SQL
      end
    end
  end
end
