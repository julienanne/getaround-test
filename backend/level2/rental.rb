require 'date'

class Rental
  attr_accessor :id
  attr_accessor :car
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :distance

  def initialize(id, car, start_date, end_date, distance)
    self.id = id
    self.car = car
    self.start_date = Date.strptime(start_date)
    self.end_date = Date.strptime(end_date)
    self.distance = distance
  end

  def get_price
    # The start and end day is included so + 1
    rent_day = (self.end_date - self.start_date) + 1

    price_per_day_base = self.car["price_per_day"]
    price_per_day_after_10_days = price_per_day_base - (price_per_day_base * 50 / 100)
    price_per_day_after_4_days = price_per_day_base - (price_per_day_base * 30 / 100)
    price_per_day_after_1_day = price_per_day_base - (price_per_day_base * 10 / 100)

    days_after_10 = rent_day > 10 ? rent_day - 10 : 0
    days_after_4 = rent_day > 4 ? rent_day - 4 - days_after_10 : 0
    days_after_1 = rent_day > 1 ? rent_day - 1 - days_after_4 - days_after_10 : 0

    price_after_10_days = days_after_10 * price_per_day_after_10_days
    price_after_4_days = days_after_4 * price_per_day_after_4_days
    price_after_1_day = days_after_1 * price_per_day_after_1_day

    price_kms = self.distance * self.car["price_per_km"]

    return (price_after_10_days + price_after_4_days + price_after_1_day + price_per_day_base + price_kms).to_i
  end

  def to_output_json
    return { "id": self.id, "price": self.get_price }
  end
end
