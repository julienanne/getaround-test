require_relative '../../level1/main'

RSpec.describe "Main" do
  describe "execute" do
    it "should create a File named data/output.json" do
      execute

      expect(File).to exist("./level1/data/output.json")
    end

    it "should populate the File named data/output.json with the rentals array containing the price from the input file data/input.json and corresponding to the expected output file" do
      execute

      expected_output = File.read("./level1/data/expected_output.json")
      actual_output = File.read("./level1/data/output.json")

      expect(actual_output).to eq(expected_output)
    end
  end


end
