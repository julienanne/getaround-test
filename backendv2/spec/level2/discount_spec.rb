require 'date'

require_relative "../../services/discount"

require_relative "../../models/rental"

RSpec.describe Discount, "object" do
  let(:rental_car) { { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 } }

  context "can calculate discount to rental" do
    describe "call" do
      it "only one day no discount" do
        rental = Rental.new(id: 1, car: rental_car, start_date: Date.strptime("2017-12-8"), end_date: Date.strptime("2017-12-8"), distance: 100)

        expect(Discount.call(rental: rental)).to eq(0)
      end

      it "price per day decreases by 10\% after 1 day" do
        rental = Rental.new(id: 2, car: rental_car, start_date: Date.strptime("2015-03-31"), end_date: Date.strptime("2015-04-01"), distance: 300)

        expect(Discount.call(rental: rental)).to eq(200)
      end

      it "price per day decreases by 30\% after 4 days" do
        rental = Rental.new(id: 3, car: rental_car, start_date: Date.strptime("2015-07-3"), end_date: Date.strptime("2015-07-7"), distance: 500)

        expect(Discount.call(rental: rental)).to eq(1200)
      end

      it "price per day decreases by 50\% after 10 days" do
        rental = Rental.new(id: 4, car: rental_car, start_date: Date.strptime("2015-07-3"), end_date: Date.strptime("2015-07-14"), distance: 1000)

        expect(Discount.call(rental: rental)).to eq(6200)
      end
    end
  end
end

