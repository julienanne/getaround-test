require_relative '../../models/rental'

RSpec.describe Rental do
  describe "get_price" do
    it "should return the rental price" do
      rental = Rental.new(id: 1, car: { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }, start_date: Date.strptime("2017-12-8"), end_date: Date.strptime("2017-12-10"), distance: 100)

      expect(rental.get_price).to eq(7000)
    end

  end
end
