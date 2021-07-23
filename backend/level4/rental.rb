require 'date'

class Rental
  attr_accessor :id
  attr_accessor :car

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = Date.strptime(start_date)
    @end_date = Date.strptime(end_date)
    @distance = distance
  end

  def get_rental_days
    # The start and end day is included so + 1
    (@end_date - @start_date) + 1
  end

  def get_price
    rental_days = get_rental_days

    price_per_day_base = @car["price_per_day"]

    return ((price_per_day_base * rental_days) + price_kms).to_i
  end

  private

  def price_kms
    @distance * @car["price_per_km"]
  end
end
