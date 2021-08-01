require_relative 'service'

class Actions < Service
  def initialize(rental_price_discounted:, commission_parts:)
    @rental_price_discounted = rental_price_discounted
    @commission_parts = commission_parts
  end

  def call
    [
      get_action("driver", "debit", @rental_price_discounted),
      get_action("owner", "credit", @rental_price_discounted - @commission_parts.values.sum),
      @commission_parts.map { |actor, amount| get_action(actor.to_s.delete_suffix("_fee"), "credit", amount) }
    ].flatten
  end

  private

  def get_action(who, type, amount)
    { who: who, type: type, amount: amount}
  end

end
