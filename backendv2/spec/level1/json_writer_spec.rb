require_relative '../../services/json_writer'

RSpec.describe JsonWriter do
  let(:path_to_output_file) { "./spec/level1/data/output.json" }
  let(:json_content) {
    '{
      "rentals": [
        {
          "id": 1
        },
        {
          "id": 2
        },
        {
          "id": 3
        }
      ]
    }'
  }

  describe "call" do
    it "should write json content to output file" do
      JsonWriter.call(output_file_path: path_to_output_file, json_content: json_content)

      actual_output = File.read(path_to_output_file)

      expect(actual_output).to eq(json_content + "\n")
    end
  end
end
