require 'dry/monads'

class Api
  include Dry::Monads[:result]

  def call
    payload = response
    Success(JSON.parse(payload))
  rescue Faraday::Error, JSON::ParserError => e
    Failure(e)
  end
end
