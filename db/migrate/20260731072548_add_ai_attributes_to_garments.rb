class AddAiAttributesToGarments < ActiveRecord::Migration[8.1]
  def change
    add_column :garments, :formality, :integer
    add_column :garments, :season, :integer
    add_column :garments, :pattern, :integer
    add_column :garments, :ai_analyzed_at, :datetime
  end
end
