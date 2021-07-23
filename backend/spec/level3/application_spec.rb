require_relative '../../level3/application'

RSpec.describe Application, "object" do

  let(:input_file_path) { "./level3/data/input.json" }
  let(:output_path) { "./level3/data/output.json" }
  let(:app) { Application.new(input_file_path) }

  before do
    File.truncate(output_path, 0)
  end

  describe "call" do
    it "should populate the File named data/output.json with the rentals array containing the price from the input file data/input.json and corresponding to the expected output file" do
      app.call

      expected_output = File.read("./level3/data/expected_output.json")
      actual_output = File.read("./level3/data/output.json")

      expect(actual_output).to eq(expected_output)
    end
  end
end
