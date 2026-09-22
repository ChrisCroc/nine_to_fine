class AddFeedIndexToOutfits < ActiveRecord::Migration[8.1]
  def change
    add_index :outfits,
              [ :visibility, :created_at, :id ],
              order: { created_at: :desc, id: :desc },
              name: "index_outfits_on_feed"
  end
end
