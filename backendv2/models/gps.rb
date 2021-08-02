class Gps
  def initialize(rental_days:)
    @rental_days = rental_days
  end

  def get_price
    { owner: 500 * @rental_days, drivy: 0 }
  end
end
