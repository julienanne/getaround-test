require_relative "../../level2/rental"

RSpec.describe Rental, "object" do
  context "is instanciate" do
    it "with the informations" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 100)
      expect(rental.id).to eq(1)
      expect(rental.car).to eq({id: 1, "price_per_day" => 2000, "price_per_km" => 10})
      expect(rental.start_date).to eq(Date.strptime("2017-12-8"))
      expect(rental.end_date).to eq(Date.strptime("2017-12-8"))
      expect(rental.distance).to eq(100)
    end
  end

  context "can calculate price" do
    it "with distance to zero" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 0)

      expect(rental.get_price).to eq(2000)
    end

    it "with distance not zero" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(1, rental_car, "2017-12-8", "2017-12-8", 100)

      expect(rental.get_price).to eq(3000)
    end

    it "price per day decreases by 10\% after 1 day" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(2, rental_car, "2015-03-31", "2015-04-01", 300)

      expect(rental.get_price).to eq(6800)
    end

    it "price per day decreases by 30\% after 4 days" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(3, rental_car, "2015-07-3", "2015-07-7", 500)

      expect(rental.get_price).to eq(13800)
    end

    it "price per day decreases by 50\% after 10 days" do
      rental_car = { id: 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(3, rental_car, "2015-07-3", "2015-07-14", 1000)

      expect(rental.get_price).to eq(27800)
    end
  end
end

