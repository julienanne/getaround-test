require 'date'

require_relative '../models/rental'

class RentalRepository
  def initialize(json_objects:)
    @json_objects = json_objects
  end

  def list
    rentals = []
    cars = @json_objects["cars"]
    @json_objects["rentals"].each do |json_rental|
      car = cars.select { |car| car["id"] == json_rental["car_id"] }.first
      rentals << Rental.new(id: json_rental["id"], car: car, start_date: Date.strptime(json_rental["start_date"]), end_date: Date.strptime(json_rental["end_date"]), distance: json_rental["distance"])
    end
    return rentals
  end
end
