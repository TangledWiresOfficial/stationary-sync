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
    rescue JWT::DecodeError => e # This can happen if the signing keys have changed
      puts e
      puts "Refreshing JWKS"
      Rails.cache.delete("jwks")
      nil
    rescue => e
      puts e.backtrace
    end

    private

    def self.fetch_keys
      Rails.cache.fetch("jwks", expires_in: 2.hours) do
        JSON.parse(Net::HTTP.get(URI("https://auth.tangledwires.co.uk/realms/master/protocol/openid-connect/certs")), symbolize_names: true)
      end
    end
  end
end
