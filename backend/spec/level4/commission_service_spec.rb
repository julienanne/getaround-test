require_relative "../../level4/commission_service"

RSpec.describe CommissionService, "object" do
  context "can split commission for a rental" do
    describe "call" do
      it "rental price 3000" do
        commissions_hash = {
          "insurance_fee": 450,
          "assistance_fee": 100,
          "drivy_fee": 350
        }

        expect(CommissionService.call(3000, 1)).to eq(commissions_hash)
      end

      it "rental price 6800" do
        commissions_hash = {
          "insurance_fee": 1020,
          "assistance_fee": 200,
          "drivy_fee": 820
        }

        expect(CommissionService.call(6800, 2)).to eq(commissions_hash)
      end
    end
  end
end
