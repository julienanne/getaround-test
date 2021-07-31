require_relative '../../level1/main'

RSpec.describe "Main" do
  let(:path_to_output_file) { "./level1/data/output.json" }
  before do
    File.delete(path_to_output_file) if File.exist?(path_to_output_file)
  end

  describe "execute" do
    it "should create a output_file" do
      execute

      expect(File).to exist(path_to_output_file)
    end

    # it "should populate the File named data/output.json with the rentals array containing the price from the input file data/input.json and corresponding to the expected output file" do
    #   execute

    #   expected_output = File.read("./level1/data/expected_output.json")
    #   actual_output = File.read("./level1/data/output.json")

    #   expect(actual_output).to eq(expected_output)
    # end
  end


end
