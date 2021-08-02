class AdditionalInsurance
  def initialize(rental_days:)
    @rental_days = rental_days
  end

  def get_price
    { owner: 0, drivy: 1000 * @rental_days }
  end
end
