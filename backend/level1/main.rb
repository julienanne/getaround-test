require_relative 'rental'

require 'json'

ACTUAL_DIR = File.expand_path(File.dirname(__FILE__))

def execute(input_path = nil)
  input_json = get_json_from_file(input_path)

  rentals = get_rentals(input_json)

  write_output_json_file(rentals)
end

def get_json_from_file(input_path)
  input_file_path = input_path || File.join(ACTUAL_DIR, 'data/input.json')
  return JSON.parse(File.read(input_file_path))
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

def write_output_json_file(rentals)
  rentals_json_with_price = rentals.map(&:to_output_json)

  output_json = JSON.generate({ "rentals" => rentals_json_with_price },
    { indent: "  ", space: " ", array_nl: "\n", object_nl: "\n" })

  File.open(File.join(ACTUAL_DIR, 'data/output.json'), "w") do |file|
    file.puts(output_json)
  end
end

if $0 == __FILE__
  execute
end
