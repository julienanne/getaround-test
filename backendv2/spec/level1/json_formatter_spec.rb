require_relative '../../services/json_formatter'

RSpec.describe JsonFormatter do
  let(:hash_content) { {rentals: [{id: 1}, {id: 2}, {id: 3}]} }
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
    it "should format hash content to json content" do
      result = JsonFormatter.call(hash_content: hash_content)

      expect(result).to eq(json_content)
    end
  end
end
