require_relative '../../repositories/rental_repository'
require_relative '../../models/rental'

RSpec.describe RentalRepository do
  let(:json_objects) { {"cars"=>[{"id"=>1, "price_per_day"=>2000, "price_per_km"=>10}, {"id"=>2, "price_per_day"=>3000, "price_per_km"=>15}, {"id"=>3, "price_per_day"=>1700, "price_per_km"=>8}], "rentals"=>[{"id"=>1, "car_id"=>1, "start_date"=>"2017-12-8", "end_date"=>"2017-12-10", "distance"=>100}, {"id"=>2, "car_id"=>1, "start_date"=>"2017-12-14", "end_date"=>"2017-12-18", "distance"=>550}, {"id"=>3, "car_id"=>2, "start_date"=>"2017-12-8", "end_date"=>"2017-12-10", "distance"=>150}]} }

  let(:json_objects_with_options) { {"cars"=>[{"id"=>1, "price_per_day"=>2000, "price_per_km"=>10}], "rentals"=>[{"id"=>1, "car_id"=>1, "start_date"=>"2015-12-8", "end_date"=>"2015-12-8", "distance"=>100}, {"id"=>2, "car_id"=>1, "start_date"=>"2015-03-31", "end_date"=>"2015-04-01", "distance"=>300}, {"id"=>3, "car_id"=>1, "start_date"=>"2015-07-3", "end_date"=>"2015-07-14", "distance"=>1000}], "options"=>[{"id"=>1, "rental_id"=>1, "type"=>"gps"}, {"id"=>2, "rental_id"=>1, "type"=>"baby_seat"}, {"id"=>3, "rental_id"=>2, "type"=>"additional_insurance"}]} }

  describe "list" do
    it "should return the rentals list" do
      rental_repository = RentalRepository.new(json_objects: json_objects)
      rentals = rental_repository.list

      expect(rentals.length).to eq(3)
      rentals.each do |rental|
        expect(rental).to be_an_instance_of(Rental)
      end
    end

    it "should return the rentals list with the rentals options" do
      rental_repository = RentalRepository.new(json_objects: json_objects_with_options)
      rentals = rental_repository.list

      expect(rentals.length).to eq(3)
      rentals.each do |rental|
        expect(rental).to be_an_instance_of(Rental)
      end

      expect(rentals.select { |rental| rental.id == 1 }.first.options).to eq(["gps", "baby_seat"])
    end
  end
end
