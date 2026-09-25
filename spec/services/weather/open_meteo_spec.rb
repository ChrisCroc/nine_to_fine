require "rails_helper"

RSpec.describe Weather::OpenMeteo do
  # Paris, as the browser sends it: more decimals than the service keeps.
  let(:paris) { [ 48.8566, 2.3522 ] }

  # The block of an Open-Meteo answer that the service reads.
  let(:conditions) do
    { "current" => { "temperature_2m" => 14.2, "weather_code" => 61, "wind_speed_10m" => 12.3 } }
  end

  def ok_response(body)
    response = Net::HTTPOK.new("1.1", "200", "OK")
    allow(response).to receive(:body).and_return(body.to_json)
    response
  end

  def unavailable_response
    Net::HTTPServiceUnavailable.new("1.1", "503", "Service Unavailable")
  end

  # Net::HTTP.start hands a connection to its block and returns what the block
  # returns. The stub hands over a fake connection: the suite never goes online.
  def stub_open_meteo(response)
    http = instance_double(Net::HTTP)
    allow(http).to receive(:request).and_return(response)
    allow(Net::HTTP).to receive(:start).and_yield(http)
    http
  end

  describe "#sentence" do
    it "turns the current conditions into one sentence for the prompt" do
      stub_open_meteo(ok_response(conditions))

      expect(described_class.new(paris).sentence)
        .to eq("Current weather at the user's location: 14.2°C, slight rain, wind 12.3 km/h.")
    end

    it "asks for the rounded position, not the one the browser sent" do
      http = stub_open_meteo(ok_response(conditions))

      described_class.new(paris).sentence

      expect(http).to have_received(:request) do |request|
        expect(request.path).to include("latitude=48.86&longitude=2.35")
      end
    end

    it "leaves out what the service did not send" do
      stub_open_meteo(ok_response("current" => { "temperature_2m" => 14.2 }))

      expect(described_class.new(paris).sentence)
        .to eq("Current weather at the user's location: 14.2°C.")
    end

    it "does not call the service when the browser sent no position" do
      allow(Net::HTTP).to receive(:start)

      expect(described_class.new(nil).sentence).to be_nil
      expect(Net::HTTP).not_to have_received(:start)
    end

    it "returns nil when the service answers with an error" do
      stub_open_meteo(unavailable_response)

      expect(described_class.new(paris).sentence).to be_nil
    end

    it "returns nil and leaves a trace when the service does not answer in time" do
      allow(Net::HTTP).to receive(:start).and_raise(Net::OpenTimeout)
      allow(Rails.logger).to receive(:warn)

      expect(described_class.new(paris).sentence).to be_nil
      expect(Rails.logger).to have_received(:warn).with(/Net::OpenTimeout/)
    end

    context "with a cache that remembers" do
      # The test environment runs on :null_store, which remembers nothing.
      before { allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new) }

      it "asks once for two positions that round to the same place" do
        stub_open_meteo(ok_response(conditions))

        described_class.new(paris).sentence
        described_class.new([ 48.8571, 2.3519 ]).sentence

        expect(Net::HTTP).to have_received(:start).once
      end

      it "does not remember a failure" do
        http = stub_open_meteo(unavailable_response)
        described_class.new(paris).sentence

        allow(http).to receive(:request).and_return(ok_response(conditions))

        expect(described_class.new(paris).sentence).to start_with("Current weather")
        expect(Net::HTTP).to have_received(:start).twice
      end
    end
  end
end
