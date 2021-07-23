require_relative 'rental'
require_relative 'discount_service'
require_relative 'commission_service'

require 'json'

class Application
  ACTUAL_DIR = File.expand_path(File.dirname(__FILE__))

  def initialize(input_file_path)
    @input_file_path = input_file_path || File.join(ACTUAL_DIR, "data", "input.json")
  end

  def call
    input_json = get_json_from_file

    rentals = get_rentals(input_json)

    rentals_informations = complete_rentals_information(rentals)

    write_output_json_file(rentals_informations)
  end


  private

  def get_json_from_file
    return JSON.parse(File.read(@input_file_path))
  end

  def get_rentals(input_json)
    rentals = []
    cars = input_json["cars"]

    input_json["rentals"].each do |rental|
      car = cars.select { |car| car["id"] == rental["car_id"] }.first
      rentals << Rental.new(rental["id"], car, rental["start_date"], rental["end_date"], rental["distance"])
    end

    return rentals
  end

  def complete_rentals_information(rentals)
    rentals_hash = []

    rentals.each do |rental|
      discount = DiscountService.new(rental).call
      final_price = (rental.get_price - discount).to_i

      commission_parts = CommissionService.new(final_price, rental.get_rental_days).call

      rentals_hash << { "id": rental.id, "price": final_price, "commission": commission_parts }
    end

    return rentals_hash
  end

  def write_output_json_file(rentals_informations)
    output_json = JSON.generate({ "rentals" => rentals_informations },
      { indent: "  ", space: " ", array_nl: "\n", object_nl: "\n" })

    File.open(File.join(ACTUAL_DIR, 'data/output.json'), "w") do |file|
      file.puts(output_json)
    end
  end

end
