require_relative 'service'

class Actions < Service
  def initialize(rental_price_discounted:, commission_parts:, options_parts: { owner: 0, drivy: 0 })
    @rental_price_discounted = rental_price_discounted
    @commission_parts = commission_parts
    @options_parts = options_parts
  end

  def call
    [
      get_action("driver", "debit", @rental_price_discounted + @options_parts.values.sum),
      get_action("owner", "credit", @rental_price_discounted - @commission_parts.values.sum + @options_parts[:owner]),
      @commission_parts.map { |actor, amount| get_action(actor.to_s.delete_suffix("_fee"), "credit", get_amount(actor, amount)) }
    ].flatten
  end

  private

  def get_action(who, type, amount)
    { who: who, type: type, amount: amount.to_i}
  end

  def get_amount(actor, amount)
    if actor == :drivy_fee
      return amount + @options_parts[:drivy]
    end
    return amount
  end

end
