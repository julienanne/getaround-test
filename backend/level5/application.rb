require_relative 'rental'
require_relative 'discount_service'
require_relative 'commissions_parts_service'
require_relative 'options_parts_service'

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
    options_by_rental = input_json["options"]

    input_json["rentals"].each do |rental|
      car = cars.select { |car| car["id"] == rental["car_id"] }.first

      options_rental = options_by_rental.select { |option| option["rental_id"] == rental["id"] }
      options = options_rental.collect { |option| option["type"] }

      rentals << Rental.new(rental["id"], car, rental["start_date"], rental["end_date"], rental["distance"], options)
    end

    return rentals
  end

  def complete_rentals_information(rentals)
    return rentals.map do |rental|
      { "id": rental.id, "options": rental.options, "actions": get_actions(rental) }
    end
  end

  def write_output_json_file(rentals_informations)
    output_json = JSON.pretty_generate({ "rentals" => rentals_informations }).gsub('[

      ]', "[]") # Monkey patch for the empty array

    File.open(File.join(ACTUAL_DIR, 'data/output.json'), "w") do |file|
      file.puts(output_json)
    end
  end

  def get_actions(rental)
    discounted_price = get_discounted_price(rental)

    options_parts = get_options_parts(rental.get_rental_days, rental.options)

    price_with_options_parts = (discounted_price + options_parts.values.sum).to_i

    commission_parts = get_commission_parts(discounted_price, rental.get_rental_days)

    owner_gains = (discounted_price - commission_parts.values.sum + options_parts[:owner]).to_i

    actions = get_parts("driver", "debit", price_with_options_parts)
    actions += get_parts("owner", "credit", owner_gains)

    commission_parts.each do |type_fee, part_amount|
      amount = part_amount

      if type_fee == :drivy_fee
        amount += options_parts[:drivy].to_i
      end

      actor = type_fee.to_s.delete_suffix("_fee")

      actions += get_parts(actor, "credit", amount)
    end

    return actions
  end

  def get_discounted_price(rental)
    discount = DiscountService.call(rental)
    return (rental.get_base_price - discount).to_i
  end

  def get_options_parts(rental_days, options)
    OptionsPartsService.call(rental_days, options)
  end

  def get_commission_parts(discounted_price, rental_days)
    CommissionsPartsService.call(discounted_price, rental_days)
  end

  def get_parts(who, type, amount)
    [{"who": who, "type": type, "amount": amount}]
  end
end
