class DiscountService
  def initialize(rental)
    @rental = rental
  end

  def call
    rental_days = @rental.get_rental_days

    return 0 if rental_days == 1

    days_after_10 = rental_days > 10 ? rental_days - 10 : 0
    days_after_4 = rental_days > 4 ? rental_days - 4 - days_after_10 : 0
    days_after_1 = rental_days > 1 ? rental_days - 1 - days_after_4 - days_after_10 : 0

    return discount_after_days(days_after_1, 10) +
      discount_after_days(days_after_4, 30) +
      discount_after_days(days_after_10, 50)
  end

  private

  def discount_after_days(days, percent)
    discount_per_day = (@rental.car["price_per_day"] * percent / 100)
    return days * discount_per_day
  end
end
