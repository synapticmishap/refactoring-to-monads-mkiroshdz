class FindContact < Api
  def initialize(id)
    @id = id
  end

  def call
    super.fmap { |p| p.fetch('contact') }
  end

  private

  def response
    Rails.configuration.api.get("/contacts/#{@id}").body
  end
end
