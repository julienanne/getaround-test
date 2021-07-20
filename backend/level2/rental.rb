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
    days_after_10 = rent_day > 10 ? rent_day - 10 : 0
    days_after_4 = rent_day > 4 ? rent_day - 4 - days_after_10 : 0
    days_after_1 = rent_day > 1 ? rent_day - 1 - days_after_4 - days_after_10 : 0

    price_per_day_base = self.car["price_per_day"]

    return (
      (price_per_day_base * rent_day) -
      discount_after_days(days_after_10, 50) -
      discount_after_days(days_after_4, 30) -
      discount_after_days(days_after_1, 10) +
      price_kms
      ).to_i
  end

  def to_output_json
    return { "id": self.id, "price": self.get_price }
  end

  private
  def discount_after_days(days, percent)
    discount_per_day = (self.car["price_per_day"] * percent / 100)
    return days * discount_per_day
  end

  def price_kms
    self.distance * self.car["price_per_km"]
  end
end
