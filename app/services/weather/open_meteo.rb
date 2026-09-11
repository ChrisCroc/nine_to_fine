require "net/http"

module Weather
  # Current conditions from Open-Meteo. No API key: the free tier is open for
  # non-commercial use, and the data is CC BY 4.0 - the credit shown next to the
  # suggestion is the counterpart, not a courtesy.
  # https://open-meteo.com/en/docs
  #
  # Returns ONE English sentence meant to be dropped into a prompt, or nil.
  # /!\ nil is a normal outcome, never an incident: the stylist has to keep
  # working when a free third-party service is slow, down, or throttling us.
  class OpenMeteo
    ENDPOINT = "https://api.open-meteo.com/v1/forecast"
    MEASUREMENTS = "temperature_2m,weather_code,wind_speed_10m".freeze

    # /!\ Net::HTTP retries once on its own (max_retries defaults to 1), so the
    # worst case is TIMEOUT * 2. Budget on attempts, not on the timeout - the
    # exact lesson of the Anthropic request options (#217).
    TIMEOUT = 3

    # Two decimals is about a kilometre: precise enough to dress for, and it
    # collapses near-identical positions onto a single cache key.
    PRECISION = 2
    CACHE_TTL = 30.minutes

    # WMO weather interpretation codes, as published in the Open-Meteo docs.
    DESCRIPTIONS = {
      0 => "clear sky", 1 => "mainly clear", 2 => "partly cloudy", 3 => "overcast",
      45 => "fog", 48 => "depositing rime fog",
      51 => "light drizzle", 53 => "moderate drizzle", 55 => "dense drizzle",
      56 => "light freezing drizzle", 57 => "dense freezing drizzle",
      61 => "slight rain", 63 => "moderate rain", 65 => "heavy rain",
      66 => "light freezing rain", 67 => "heavy freezing rain",
      71 => "slight snowfall", 73 => "moderate snowfall", 75 => "heavy snowfall",
      77 => "snow grains",
      80 => "slight rain showers", 81 => "moderate rain showers", 82 => "violent rain showers",
      85 => "slight snow showers", 86 => "heavy snow showers",
      95 => "thunderstorm", 96 => "thunderstorm with slight hail", 99 => "thunderstorm with heavy hail"
    }.freeze

    def initialize(coordinates)
      @coordinates = Array(coordinates).map { |degree| degree.round(PRECISION) }
    end

    def sentence
      return if @coordinates.empty?

      Rails.cache.fetch(cache_key, expires_in: CACHE_TTL, skip_nil: true) { build }
    end

    private

    def cache_key
      "weather/open_meteo/#{@coordinates.join('/')}"
    end

    def build
      current = read.to_h["current"].to_h
      return if current.empty?

      temperature = current["temperature_2m"]
      sky = DESCRIPTIONS[current["weather_code"]]
      wind = current["wind_speed_10m"]

      parts = [ ("#{temperature}°C" if temperature), sky, ("wind #{wind} km/h" if wind) ].compact
      return if parts.empty?

      "Current weather at the user's location: #{parts.join(', ')}."
    end

    def read
      latitude, longitude = @coordinates
      uri = URI(ENDPOINT)
      uri.query = URI.encode_www_form(latitude:, longitude:, current: MEASUREMENTS)

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true,
                                 open_timeout: TIMEOUT, read_timeout: TIMEOUT) do |http|
        http.request(Net::HTTP::Get.new(uri))
      end
      return unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    rescue => e
      # A free service with no uptime guarantee never takes the stylist down.
      Rails.logger.warn("[Weather::OpenMeteo] #{e.class}: #{e.message}")
      nil
    end
  end
end
