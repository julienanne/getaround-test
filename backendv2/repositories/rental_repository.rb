require 'date'

require_relative '../models/rental'

class RentalRepository
  def initialize(json_objects:)
    @json_objects = json_objects
  end

  def list
    rentals = []
    cars_json = @json_objects["cars"]
    options_json = @json_objects["options"]
    @json_objects["rentals"].each do |json_rental|
      car = cars_json.select { |car| car["id"] == json_rental["car_id"] }.first
      if options_json.nil?
        options = []
      else
        options = options_json.select { |opt| opt["rental_id"] == json_rental["id"] }.map { |option| option["type"] }
      end
      rentals << Rental.new(id: json_rental["id"], car: car, start_date: Date.strptime(json_rental["start_date"]), end_date: Date.strptime(json_rental["end_date"]), distance: json_rental["distance"], options: options)
    end
    return rentals
  end
end
