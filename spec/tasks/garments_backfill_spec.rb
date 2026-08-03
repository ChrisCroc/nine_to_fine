require "rails_helper"
require "rake"

RSpec.describe "garments:backfill_ai_tags", type: :task do
  before(:all) do
    Rails.application.load_tasks if Rake::Task.tasks.empty?
  end

  before { Rake::Task["garments:backfill_ai_tags"].reenable }

  let(:user) { create(:user) }
  let(:leaf) { create(:category, :leaf) }

  def with_photo(garment)
    garment.photo.attach(io: File.open(Rails.root.join("spec/fixtures/files/valid.jpg")),
                        filename: "valid.jpg", content_type: "image/jpeg")
    garment
  end

  def stub_tag(result)
    allow(Ai::GarmentTagger)
    .to receive(:new).and_return(instance_double(Ai::GarmentTagger, tag: result))
  end

  it "tags a garment that has a photo and was never analysed" do
    garment = with_photo(create(:garment, user: user))
    stub_tag(Ai::GarmentTagger::Result.new(
      color: "white", category_id: leaf.id, name: "white shirt",
      formality: "formal", season: "winter", pattern: "solid"
    ))

    Rake::Task["garments:backfill_ai_tags"].invoke

    garment.reload
    expect(garment.formality).to eq("formal")
    expect(garment.ai_analyzed_at).to be_present
  end

  it "skips garments with no photo" do
    create(:garment, user: user)
    expect(Ai::GarmentTagger).not_to receive(:new)
    Rake::Task["garments:backfill_ai_tags"].invoke
  end

  it "is idempotent: a second run does nothing" do
    garment = with_photo(create(:garment, user: user, ai_analyzed_at: 1.day.ago))

    expect(Ai::GarmentTagger).not_to receive(:new)
    Rake::Task["garments:backfill_ai_tags"].invoke
    expect(garment.reload.ai_analyzed_at).to be_within(1.minutes).of(1.day.ago)
  end
end
