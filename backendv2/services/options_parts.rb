require_relative 'service'

class OptionsParts < Service
  def initialize(rental_days:, options:)
    @rental_days = rental_days
    @options = options
  end

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
