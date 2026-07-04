require "rails_helper"

RSpec.describe Ai::OutfitSuggester do
  let(:user) { create(:user) }

  def fake_response(garment_ids:, name: "Sharp & Warm", rationale: "Layers for 13°C.")
    block = double("ToolUseBlock",
                    type: :tool_use,
                    name: "propose_outfit",
                    input: { garment_ids:, name:, rationale: })
    double("Message", content: [ block ])
  end

  def client_returning(response)
    client = instance_double(Anthropic::Client)
    messages = double("messages")
    allow(client).to receive(:messages).and_return(messages)
    allow(messages).to receive(:create).and_return(response)
    client
  end

  describe "#suggest" do
    it "raises TooFewGarments for a wardrobe below the minimum" do
      create(:garment, user: user)
      client = double("Anthropic::Client")

      suggester = described_class.new(user: user, context: "x", client: client)

      expect { suggester.suggest }.to raise_error(described_class::TooFewGarments)
    end

    it "parses the tool_use block into a Result" do
      pieces = create_list(:garment, 3, user: user)
      client = client_returning(fake_response(garment_ids: pieces.map(&:id), name: "Cosy", rationale: "Warm."))

      result = described_class.new(user: user, context: "cold day", client: client).suggest

      expect(result).to be_a(described_class::Result)
      expect(result.garment_ids).to match_array(pieces.map(&:id))
      expect(result.name).to eq("Cosy")
      expect(result.rationale).to eq("Warm.")
    end

    it "drops ids that are not the user's (invented or foreign)" do
      mine = create_list(:garment, 3, user: user)
      stranger = create(:garment)

      client = client_returning(fake_response(garment_ids: mine.map(&:id) + [ stranger.id, 999_999 ]))
      result = described_class.new(user: user, context: "x", client: client).suggest

      expect(result.garment_ids).to match_array(mine.map(&:id))
    end

    it "raises NoValidGarments when nothing survives validation" do
      create_list(:garment, 3, user: user)
      client = client_returning(fake_response(garment_ids: [ 999_999 ]))

      expect { described_class.new(user: user, context: "x", client: client).suggest }
        .to raise_error(described_class::NoValidGarments)
    end

    it "sends the wardrobe inventory (with ids) to the model" do
      shirt = create(:garment, user: user, name: "White shirt")
      create_list(:garment, 2, user: user)

      messages = double("messages")
      client = instance_double(Anthropic::Client, messages: messages)
      allow(messages).to receive(:create).and_return(fake_response(garment_ids: [ shirt.id ]))

      described_class.new(user: user, context: "interview", client: client).suggest

      expect(messages).to have_received(:create) do |args|
        prompt = args[:messages].first[:content]
        expect(prompt).to include("[#{shirt.id}]").and include("White shirt")
      end
    end

    it "lists the user's existing outfits in the prompt (so they aren't re-proposed)" do
      pieces = create_list(:garment, 4, user: user)
      create(:outfit, user: user, name: "Casual Friday", garments: pieces.first(3))
      create(:outfit, user: user, name: "Date Night", garments: [ pieces[0], pieces[1], pieces[3] ])

      messages = double("messages")
      client = instance_double(Anthropic::Client, messages: messages)
      allow(messages).to receive(:create).and_return(fake_response(garment_ids: pieces.last(3).map(&:id)))

      described_class.new(user: user, context: "x", client: client).suggest

      expect(messages).to have_received(:create) do |args|
        prompt = args[:messages].first[:content]
        expect(prompt).to include("Casual Friday")
      end
    end

    it "raises DuplicateOutfit when the proposed set is one the user already owns" do
      pieces = create_list(:garment, 3, user: user)
      create(:outfit, user: user, name: "Casual Friday", garments: pieces)
      client = client_returning(fake_response(garment_ids: pieces.map(&:id)))

      expect { described_class.new(user: user, context: "x", client: client).suggest }
        .to raise_error(described_class::DuplicateOutfit)
    end
  end
end
