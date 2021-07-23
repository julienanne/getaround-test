require_relative "../../level4/discount_service"

RSpec.describe DiscountService, "object" do
  let(:rental_car) { { id: 1, "price_per_day" => 2000, "price_per_km" => 10 } }

  context "can calculate discount to rental" do
    describe "call" do
      it "only one day no discount" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 100)

        expect(DiscountService.call(rental)).to eq(0)
      end

      it "price per day decreases by 10\% after 1 day" do
        rental = Rental.new(2, rental_car, "2015-03-31", "2015-04-01", 300)

        expect(DiscountService.call(rental)).to eq(200)
      end

      it "price per day decreases by 30\% after 4 days" do
        rental = Rental.new(3, rental_car, "2015-07-3", "2015-07-7", 500)

        expect(DiscountService.call(rental)).to eq(1200)
      end

      it "price per day decreases by 50\% after 10 days" do
        rental = Rental.new(4, rental_car, "2015-07-3", "2015-07-14", 1000)

        expect(DiscountService.call(rental)).to eq(6200)
      end
    end
  end
end

