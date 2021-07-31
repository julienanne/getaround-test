class Rental
  attr_reader :id

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance
  end

  def get_price
    return (get_price_for_days + get_price_for_km).to_i
  end

  private

  def get_price_for_km
    @distance * @car["price_per_km"]
  end

  def get_price_for_days
    number_of_days * @car["price_per_day"]
  end

  def number_of_days
    # The start and end day is included so + 1
    @end_date - @start_date + 1
  end
end
