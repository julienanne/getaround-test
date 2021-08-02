class BabySeat
  def initialize(rental_days:)
    @rental_days = rental_days
  end

  def get_price
    { owner: 200 * @rental_days, drivy: 0 }
  end
end
