require 'json'

ACTUAL_DIR = File.expand_path(File.dirname(__FILE__))

def execute(input_path = nil)
  input_json = get_json_from_file(input_path)

  rentals = get_rentals(input_json)

  rentals_only_ids = rentals.map do |rental|
    rental.select { |attribute, value| attribute == "id" }
  end

  write_output_json_file(rentals_only_ids)
end

def get_json_from_file(input_path)
  input_file_path = input_path || File.join(ACTUAL_DIR, 'data/input.json')
  return JSON.parse(File.read(input_file_path))
end

def get_rentals(input_json)
  rentals = []
  cars = input_json["cars"]
  input_json["rentals"].each do |rental|
    car = cars.select { |car| car["id"] == rental["car_id"] }
    rentals << Rental.new(rental["id"], car, rental["start_date"], rental["end_date"], rental["distance"])
  end
end

def write_output_json_file(rentals)
  output_json = JSON.generate({ "rentals" => rentals },
    { indent: "  ", space: " ", array_nl: "\n", object_nl: "\n" })

  File.open(File.join(ACTUAL_DIR, 'data/output.json'), "w") do |file|
    file.puts(output_json)
  end
end

if $0 == __FILE__
  execute
end
