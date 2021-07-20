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
    (rent_day * self.car[:price_per_day] + self.distance * self.car[:price_per_km]).to_i
  end
end
