require 'dry/monads'

class AddressesController < ApplicationController
  include Dry::Monads[:result]

  def edit
    render :edit_with_error and return if postcode.failure?

    LookupPostcode.new(postcode.value!).call
                  .fmap { |a| render :edit_with_address_select, locals: { addresses: a } }
                  .or { render :edit_with_manual_address_entry }
  end

  # private

  def postcode
    id = params[:contact_id]
    @postcode ||= FindContact.new(id).call.fmap { |c| c['postcode'] }
  end
end
