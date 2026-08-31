require "net/http"

module Utils
  module Auth
    # This will only work in tests
    mattr_accessor :test_data, instance_accessor: false

    def self.decode_token(token)
      return test_data if test_data && Rails.env.test?

      decoded = JWT.decode(
        token,
        nil,
        true,
        algorithm: "RS256",
        jwks: fetch_keys,

        verify_iss: true,
        iss: "https://auth.tangledwires.co.uk/realms/master",

        verify_aud: true,
        aud: "stationary-sync",

        verify_expiration: true
      )

      decoded.first
    rescue JWT::DecodeError # This can happen if the signing keys have changed
      Rails.cache.delete("jwks")
      nil
    end

    private

    def self.fetch_keys
      Rails.cache.fetch("jwks", expires_in: 2.hours) do
        JSON.parse(Net::HTTP.get(URI("https://accounts.tangledwires.co.uk/application/o/stationary-sync/jwks/")), symbolize_names: true)
      end
    end
  end
end
