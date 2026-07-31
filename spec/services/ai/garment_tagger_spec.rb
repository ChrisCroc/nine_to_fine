require "rails_helper"

RSpec.describe Ai::GarmentTagger do
  let(:photo) { double("upload", read: "fake-bytes", content_type: "image/jpeg") }

  def fake_response(input)
    block = double("ToolUseBlock", type: :tool_use, name: "record_garment", input: input)
    double("Message", content: [ block ])
  end

  def client_returning(response)
    client = instance_double(Anthropic::Client)
    messages = double("messages")
    allow(client).to receive(:messages).and_return(messages)
    allow(messages).to receive(:create).and_return(response)
    client
  end

  describe "#tag" do
    it "parses the tool_use block into a validated Result" do
      leaf = create(:category, :leaf, name: "shirt")
      client = client_returning(fake_response(
        color: "white", category: "shirt", name: "White linen shirt",
        formality: "smart_casual", season: "summer", pattern: "solid"
      ))

      result = described_class.new(photo: photo, client: client).tag

      expect(result).to be_a(described_class::Result)
      expect(result.color).to eq("white")
      expect(result.category_id).to eq(leaf.id)
      expect(result.name).to eq("White linen shirt")
      expect(result.formality).to eq("smart_casual")
      expect(result.season).to eq("summer")
      expect(result.pattern).to eq("solid")
    end

    it "nils a colour outside the whitelist" do
      create(:category, :leaf, name: "shirt")
      client = client_returning(fake_response(color: "chartreuse", category: "shirt"))
      expect(described_class.new(photo: photo, client: client).tag.color).to be_nil
    end

    it "nils a category that is not an existing leaf" do
      client = client_returning(fake_response(color: "white", category: "spaceship"))
      expect(described_class.new(photo: photo, client: client).tag.category_id).to be_nil
    end

    it "nils an axis the model omitted" do
      create(:category, :leaf, name: "shirt")
      client = client_returning(fake_response(color: "white", category: "shirt"))
      result = described_class.new(photo: photo, client: client).tag
      expect(result.formality).to be_nil
      expect(result.season).to be_nil
      expect(result.pattern).to be_nil
    end

    it "raises when the response has no tool_use block" do
      empty = double("Message", content: [])
      client = client_returning(empty)
      expect { described_class.new(photo: photo, client: client).tag }
        .to raise_error(described_class::Error)
    end

    it "raises on an image type Claude vision cannot read" do
      heic = double("upload", read: "x", content_type: "image/heic")
      client = client_returning(fake_response(color: "white"))
      expect { described_class.new(photo: heic, client: client).tag }
        .to raise_error(described_class::Error, /unsupported image type/)
    end

    it "sends the photo as an image content block" do
      create(:category, :leaf, name: "shirt")
      messages = double("messages")
      client = instance_double(Anthropic::Client, messages: messages)
      allow(messages).to receive(:create).and_return(fake_response(color: "white", category: "shirt"))

      described_class.new(photo: photo, client: client).tag

      expect(messages).to have_received(:create) do |args|
        blocks = args[:messages].first[:content]
        image = blocks.find { |b| b[:type] == "image" }
        expect(image[:source][:media_type]).to eq("image/jpeg")
        expect(image[:source][:type]).to eq("base64")
      end
    end
  end
end
