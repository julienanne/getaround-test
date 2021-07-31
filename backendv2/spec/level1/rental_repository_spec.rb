require_relative '../../repositories/rental_repository'
require_relative '../../models/rental'

RSpec.describe RentalRepository do
  let(:json_objects) { {"cars"=>[{"id"=>1, "price_per_day"=>2000, "price_per_km"=>10}, {"id"=>2, "price_per_day"=>3000, "price_per_km"=>15}, {"id"=>3, "price_per_day"=>1700, "price_per_km"=>8}], "rentals"=>[{"id"=>1, "car_id"=>1, "start_date"=>"2017-12-8", "end_date"=>"2017-12-10", "distance"=>100}, {"id"=>2, "car_id"=>1, "start_date"=>"2017-12-14", "end_date"=>"2017-12-18", "distance"=>550}, {"id"=>3, "car_id"=>2, "start_date"=>"2017-12-8", "end_date"=>"2017-12-10", "distance"=>150}]} }

  describe "list" do
    it "should return the rentals list" do
      rental_repository = RentalRepository.new(json_objects: json_objects)
      rentals = rental_repository.list

      expect(rentals.length).to eq(3)
      rentals.each do |rental|
        expect(rental).to be_an_instance_of(Rental)
      end
    end
  end
end
