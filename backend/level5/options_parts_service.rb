require_relative 'service'

class OptionsPartsService < Service
  def initialize(rental_days, options)
    @rental_days = rental_days
    @options = options
  end

  def call
    options_parts = { owner: 0, drivy: 0 }
    @options.each do |option|
      if option == "gps"
        options_parts[:owner] += 500 * @rental_days
      elsif option == "baby_seat"
        options_parts[:owner] += 200 * @rental_days
      elsif option == "additional_insurance"
        options_parts[:drivy] += 1000 * @rental_days
      end
    end
    return options_parts
  end
end
