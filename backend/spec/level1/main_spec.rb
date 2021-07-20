require_relative '../../level1/main'

RSpec.describe "Main" do
  describe "can execute" do
    context "for level1" do
      it "create a File named data/output.json" do
        execute

        expect(File).to exist("./level1/data/output.json")
      end

      it "populate the File named data/output.json with the rentals array" do
        execute("./level1/data/input2.json")

        expected_output = "{\n  \"rentals\": [\n    {\n      \"id\": 1\n    },\n    {\n      \"id\": 2\n    }\n  ]\n}\n"
        actual_output = File.read("./level1/data/output.json")

        expect(actual_output).to eq(expected_output)
      end

      it "populate the File named data/output.json with the rentals array from the input file data/input.json" do
        execute

        expected_output = "{\n  \"rentals\": [\n    {\n      \"id\": 1\n    },\n    {\n      \"id\": 2\n    },\n    {\n      \"id\": 3\n    }\n  ]\n}\n"
        actual_output = File.read("./level1/data/output.json")

        expect(actual_output).to eq(expected_output)
      end
    end
  end
end
