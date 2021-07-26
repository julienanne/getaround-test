require 'date'

class Rental
  attr_reader :id
  attr_reader :car
  attr_reader :options

  def initialize(id, car, start_date, end_date, distance, options = [])
    @id = id
    @car = car
    @start_date = Date.strptime(start_date)
    @end_date = Date.strptime(end_date)
    @distance = distance
    @options = options
  end

  def get_rental_days
    # The start and end day is included so + 1
    (@end_date - @start_date) + 1
  end

  def get_base_price
    return (price_days + price_kms).to_i
  end

  private

  def price_days
    get_rental_days * @car["price_per_day"]
  end

  def price_kms
    @distance * @car["price_per_km"]
  end
end
