require_relative '../services/service'
require_relative '../services/json_reader'
require_relative '../services/json_formatter'
require_relative '../services/json_writer'
require_relative '../services/discount'
require_relative '../repositories/rental_repository'

ACTUAL_DIR = File.expand_path(File.dirname(__FILE__))

class App < Service
  def initialize(input_file_path:, output_file_path:)
    @input_file_path = input_file_path
    @output_file_path = output_file_path
  end

  def call
    json_input = get_json_from_input_file


    rental_repository = RentalRepository.new(json_objects: get_json_from_input_file)

    rentals = rental_repository.list

    rentals_transformed = rentals.map { |rental| { id: rental.id, price: price_discounted(rental) } }


    json_content = format_json_content(rentals_transformed)

    write_json_to_file(json_content)
  end

  private

  def get_json_from_input_file
    JsonReader.call(input_file_path: @input_file_path)
  end

  def format_json_content(rentals_transformed)
    JsonFormatter.call(hash_content: { rentals: rentals_transformed })
  end

  def write_json_to_file(json_content)
    JsonWriter.call(output_file_path: @output_file_path, json_content: json_content)
  end

  def price_discounted(rental)
    (rental.get_price - Discount.call(rental: rental)).to_i
  end
end

if $0 == __FILE__
  App.call(input_file_path: File.join(ACTUAL_DIR, 'data/input.json'), output_file_path: File.join(ACTUAL_DIR, 'data/output.json'))
end

