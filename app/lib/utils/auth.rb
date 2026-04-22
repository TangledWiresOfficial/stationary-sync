module Utils::Auth
  def self.decode_token(token)
    decoded = JWT.decode(
      token,
      nil,
      true,
      algorithm: "RS256",
      jwks: fetch_keys,

      verify_iss: true,
      iss: "https://accounts.tangledwires.co.uk/",

      verify_aud: true,
      aud: "OdZvDUTEsD7mArYdKAQbW2MbzyNtghk7pqEY26TA",

      verify_expiration: true
    )

    decoded.first
  rescue JWT::DecodeError # This can happen if the signing keys are changed
    Rails.cache.delete("jwks")
    retry
  end

  private

  def fetch_keys
    Rails.cache.fetch("jwks", expires_in: 2.hours) do
      JSON.parse(Net::HTTP.get(URI("https://accounts.tangledwires.co.uk/application/o/stationary-sync/jwks/")), symbolize_names: true)
    end
  end
end