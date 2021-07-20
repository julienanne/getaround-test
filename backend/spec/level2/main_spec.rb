require_relative '../../level2/main'

RSpec.describe "Main" do
  describe "execute" do
    it "should populate the File named data/output.json with the rentals array containing the price from the input file data/input.json and corresponding to the expected output file" do
      execute

      expected_output = File.read("./level2/data/expected_output.json")
      actual_output = File.read("./level2/data/output.json")

      expect(actual_output).to eq(expected_output)
    end
  end
end
