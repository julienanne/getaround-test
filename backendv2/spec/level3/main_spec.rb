require_relative '../../level3/main'

RSpec.describe App do
  let(:path_to_input_file) { "./spec/level3/data/input.json" }
  let(:path_to_output_file) { "./spec/level3/data/output.json" }
  before do
    File.delete(path_to_output_file) if File.exist?(path_to_output_file)
  end

  describe "call" do
    it "should populate the File named data/output.json with the rentals array containing the price from the input file data/input.json and corresponding to the expected output file" do
      App.call(input_file_path: path_to_input_file, output_file_path: path_to_output_file)

      expected_output = File.read("./level3/data/expected_output.json")
      actual_output = File.read(path_to_output_file)

      expect(actual_output).to eq(expected_output)
    end
  end


end
