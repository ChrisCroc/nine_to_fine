namespace :garments do
  desc "backfill AI vision tags on existing garments that have a photo"
  task backfill_ai_tags: :environment do
    scope = Garment.where(ai_analyzed_at: nil)
    tagged = 0

    scope.find_each do |garment|
      next unless garment.photo.attached?

      result = Ai::GarmentTagger.new(photo: garment.photo).tag
      garment.update!(
        color: result.color || garment.color,
        category_id: result.category_id || garment.category_id,
        name: result.name.presence || garment.name,
        formality: result.formality,
        season: result.season,
        pattern: result.pattern,
        ai_analyzed_at: Time.current
      )
      tagged += 1
      puts "Tagged garment ##{garment.id}"
    rescue Ai::GarmentTagger::Error => e
      warn "Skipped garment ##{garment.id}: #{e.message}"
    end

    puts "Backfill complete — #{tagged} garment(s) tagged"
  end
end
