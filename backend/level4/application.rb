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
    return rentals.map { |rental| { "id": rental.id, "actions": get_actions(rental) } }
  end

  def write_output_json_file(rentals_informations)
    output_json = JSON.generate({ "rentals" => rentals_informations },
      { indent: "  ", space: " ", array_nl: "\n", object_nl: "\n" })

    File.open(File.join(ACTUAL_DIR, 'data/output.json'), "w") do |file|
      file.puts(output_json)
    end
  end

  def get_actions(rental)
    discounted_price = get_discounted_price(rental)

    commission_parts = get_commission_parts_by_actor(discounted_price, rental.get_rental_days)

    owner_gains = discounted_price - commission_parts.values.sum

    actions = get_parts("driver", "debit", discounted_price)
    actions += get_parts("owner", "credit", owner_gains)

    commission_parts.each do |type_fee, amount|
      actions += get_parts(type_fee.to_s.delete_suffix("_fee"), "credit", amount)
    end

    return actions
  end

  def get_discounted_price(rental)
    discount = DiscountService.call(rental)
    return (rental.get_price - discount).to_i
  end

  def get_commission_parts_by_actor(discounted_price, rental_days)
    CommissionService.call(discounted_price, rental_days)
  end

  def get_parts(who, type, amount)
    [{"who": who, "type": type, "amount": amount}]
  end
end
