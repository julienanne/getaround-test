require_relative "../../level3/rental"

RSpec.describe Rental, "object" do
  let(:rental_car) { { id: 1, "price_per_day" => 2000, "price_per_km" => 10 } }

  context "can get rental days" do
    describe "get_rental_days" do
      it "return the number of rental days same date" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0)

        expect(rental.get_rental_days).to eq(1)
      end

      it "return the number of rental days same date" do
        rental = Rental.new(1, rental_car, "2017-12-3", "2017-12-14", 0)

        expect(rental.get_rental_days).to eq(12)
      end
    end
  end

  context "can calculate price" do
    describe "get_price" do
      it "with distance to zero" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0)

        expect(rental.get_price).to eq(2000)
      end

      it "with distance not zero" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 100)

        expect(rental.get_price).to eq(3000)
      end
    end
  end
end

