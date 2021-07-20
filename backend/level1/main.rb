require 'json'

ACTUAL_DIR = File.expand_path(File.dirname(__FILE__))

def execute(input_path = nil)
  input_json = get_json_from_file(input_path)

  rentals = get_id_for_rentals(input_json)

  write_output_json_file(rentals)
end

def get_json_from_file(input_path)
  input_file_path = input_path || File.join(ACTUAL_DIR, 'data/input.json')
  return JSON.parse(File.read(input_file_path))
end

def get_id_for_rentals(input_json)
  return input_json["rentals"].map do |rental|
    rental.select { |attribute, value| attribute == "id" }
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
