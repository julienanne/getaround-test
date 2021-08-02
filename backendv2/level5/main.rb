require_relative '../services/service'
require_relative '../services/json_reader'
require_relative '../services/json_formatter'
require_relative '../services/json_writer'
require_relative '../services/discount'
require_relative '../services/commission_parts'
require_relative '../services/options_parts'
require_relative '../services/actions'
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

    rentals_transformed = transform_rentals(rentals)


    json_content_formatted = format_json_content(rentals_transformed)

    write_json_to_file(json_content_formatted)
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

  def transform_rentals(rentals)
    rentals.map do |rental|
      rental_price_discounted = price_discounted(rental)

      rental_options_parts = get_options_parts(rental.number_of_days, rental.options)

      rental_commission_parts = commission_parts(rental_price_discounted, rental.number_of_days)

      rental_actions = get_actions(rental_price_discounted, rental_commission_parts, rental_options_parts)

      { id: rental.id, options: rental.options, actions: rental_actions }
    end
  end

  def price_discounted(rental)
    (rental.get_price - Discount.call(rental: rental)).to_i
  end

  def commission_parts(rental_price, rental_days)
    CommissionParts.call(rental_price: rental_price, rental_days: rental_days)
  end

  def get_actions(rental_price_discounted, commission_parts, options_parts)
    Actions.call(rental_price_discounted: rental_price_discounted, commission_parts: commission_parts, options_parts: options_parts)
  end

  def get_options_parts(rental_days, options)
    OptionsParts.call(rental_days: rental_days, options: options)
  end
end

if $0 == __FILE__
  App.call(input_file_path: File.join(ACTUAL_DIR, 'data/input.json'), output_file_path: File.join(ACTUAL_DIR, 'data/output.json'))
end


