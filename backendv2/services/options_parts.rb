require_relative 'service'

# Not open/closed principle so require at runtime
# require_relative '../models/gps'
# require_relative '../models/baby_seat'
# require_relative '../models/additional_insurance'

class OptionsParts < Service
  def initialize(rental_days:, options:)
    @rental_days = rental_days
    @options = options
  end

  # def call
  #   # Not open/closed principle to do so polymorphism on options by type with Factory or meta programming
  #   options_parts = { owner: 0, drivy: 0 }
  #   @options.each do |option|
  #     if option == "gps"
  #       options_parts[:owner] += 500 * @rental_days
  #     elsif option == "baby_seat"
  #       options_parts[:owner] += 200 * @rental_days
  #     elsif option == "additional_insurance"
  #       options_parts[:drivy] += 1000 * @rental_days
  #     end
  #   end
  #   return options_parts
  # end

  def call
    options_parts = { owner: 0, drivy: 0 }
    @options.each do |option|
      require_relative "../models/#{option}"
      option_instance = Object::const_get(camelize(option)).new(rental_days: @rental_days)
      options_parts.merge!(option_instance.get_price) { |key, old_value, new_value| old_value + new_value }
    end
    return options_parts
  end

  private

  def camelize(option)
    option.split('_').map{ |l| l.capitalize }.join
  end
end
