require_relative 'service'

class CommissionsPartsService < Service
  def initialize(rental_price, rental_days)
    @rental_price = rental_price
    @rental_days = rental_days
  end

  def call
    base_commission = get_base_commission
    insurance_fee = (base_commission / 2).to_i # half of commission
    assistance_fee = (100 * @rental_days).to_i # 1 euro (=> 100 in output) per day
    drivy_fee = (base_commission - insurance_fee - assistance_fee).to_i # the rest

    return {
          "insurance_fee": insurance_fee,
          "assistance_fee": assistance_fee,
          "drivy_fee": drivy_fee
        }
  end

  private

  def get_base_commission
    return @rental_price * 30 / 100
  end
end
