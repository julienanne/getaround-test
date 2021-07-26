require_relative "../../level5/rental"

RSpec.describe Rental, "object" do
  let(:rental_car) { { id: 1, "price_per_day" => 2000, "price_per_km" => 10 } }

  context "can get options with options" do
    describe "options" do
      it "return a list of options passed at the initialization" do
        options = ["gps", "baby_seat", "additional_insurance"]
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0, options)
        expect(rental.options).to eq(options)
      end

      it "return a list of options passed at the initialization with empty array" do
        options = []
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0, options)
        expect(rental.options).to eq(options)
      end

      it "return an empty list of options if not passed at the initialization" do
        options = []
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0)
        expect(rental.options).to eq(options)
      end
    end
  end

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
    describe "get_base_price" do
      it "with distance to zero" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0)

        expect(rental.get_base_price).to eq(2000)
      end

      it "with distance not zero" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 100)

        expect(rental.get_base_price).to eq(3000)
      end

      it "with distance not zero and options gps and baby_seat" do
        rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 100, ["gps", "baby_seat"])

        expect(rental.get_base_price).to eq(3000)
      end

      it "with distance not zero and options additional_insurance" do
        rental = Rental.new(2, rental_car, "2015-03-31", "2015-03-31", 300, ["additional_insurance"])

        expect(rental.get_base_price).to eq(5000)
      end
    end
  end
end

