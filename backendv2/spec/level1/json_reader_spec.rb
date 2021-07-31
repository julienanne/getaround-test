require_relative '../../services/json_reader'

RSpec.describe JsonReader do
  let(:path_input_file) { "./spec/level1/data/input.json" }

  describe "call" do
    it "should convert input_file to json" do
      result = JsonReader.call(input_file_path: path_input_file)

      expect(result).to eq({"cars"=>[{"id"=>1, "price_per_day"=>2000, "price_per_km"=>10}, {"id"=>2, "price_per_day"=>3000, "price_per_km"=>15}, {"id"=>3, "price_per_day"=>1700, "price_per_km"=>8}], "rentals"=>[{"id"=>1, "car_id"=>1, "start_date"=>"2017-12-8", "end_date"=>"2017-12-10", "distance"=>100}, {"id"=>2, "car_id"=>1, "start_date"=>"2017-12-14", "end_date"=>"2017-12-18", "distance"=>550}, {"id"=>3, "car_id"=>2, "start_date"=>"2017-12-8", "end_date"=>"2017-12-10", "distance"=>150}]})
    end
  end
end
