require_relative "../../services/commission_parts"

RSpec.describe CommissionParts, "object" do
  context "can split commission for a rental" do
    describe "call" do
      it "rental price 3000" do
        commissions_hash = {
          "insurance_fee": 450,
          "assistance_fee": 100,
          "drivy_fee": 350
        }

        expect(CommissionParts.call(rental_price: 3000, rental_days: 1)).to eq(commissions_hash)
      end

      it "rental price 6800" do
        commissions_hash = {
          "insurance_fee": 1020,
          "assistance_fee": 200,
          "drivy_fee": 820
        }

        expect(CommissionParts.call(rental_price: 6800, rental_days: 2)).to eq(commissions_hash)
      end
    end
  end
end
