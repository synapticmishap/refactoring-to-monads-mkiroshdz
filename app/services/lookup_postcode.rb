class LookupPostcode < Api
  def initialize(postcode)
    @postcode = postcode
  end

  def call
    super.fmap { |p| p.fetch('addresses') }
  end

  private

  def response
    Rails.configuration.api.get("/addresses/#{@postcode}").body
  end
end
