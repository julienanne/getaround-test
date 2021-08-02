require_relative "../../services/options_parts"

RSpec.describe OptionsParts, "object" do
  context "can split parts for a rental with options" do
    describe "call" do
      it "rental days 1 and options gps" do
        options = ["gps"]
        parts_hash = {
          owner: 500,
          drivy: 0
        }

        expect(OptionsParts.call(rental_days: 1, options: options)).to eq(parts_hash)
      end

      it "rental days 1 and options baby_seat" do
        options = ["baby_seat"]
        parts_hash = {
          owner: 200,
          drivy: 0
        }

        expect(OptionsParts.call(rental_days: 1, options: options)).to eq(parts_hash)
      end

      it "rental days 1 and options additional_insurance" do
        options = ["additional_insurance"]
        parts_hash = {
          owner: 0,
          drivy: 1000
        }

        expect(OptionsParts.call(rental_days: 1, options: options)).to eq(parts_hash)
      end
    end
  end
end
