require_relative "../../level1/rental"

RSpec.describe Rental, "object" do
  context "is instanciate" do
    it "with the informations" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-10", 100)
      expect(rental.id).to eq(1)
      expect(rental.car).to eq({id: 1, "price_per_day" => 2000, "price_per_km" => 10})
      expect(rental.start_date).to eq(Date.strptime("2017-12-8"))
      expect(rental.end_date).to eq(Date.strptime("2017-12-10"))
      expect(rental.distance).to eq(100)
    end
  end

  context "can calculate price" do
    it "with distance to zero" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-10", 0)

      expect(rental.get_price).to eq(6000)
    end

    it "with distance not zero" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-10", 100)

      expect(rental.get_price).to eq(7000)
    end
  end
end
