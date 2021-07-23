require_relative "../../level3/commission_service"

RSpec.describe CommissionService, "object" do
  context "can split commission for a rental" do
    describe "call" do
      it "rental price 3000" do
        commission_service = CommissionService.new(3000, 1)

        commissions_hash = {
          "insurance_fee": 450,
          "assistance_fee": 100,
          "drivy_fee": 350
        }

        expect(commission_service.call).to eq(commissions_hash)
      end

      it "rental price 6800" do
        commission_service = CommissionService.new(6800, 2)

        commissions_hash = {
          "insurance_fee": 1020,
          "assistance_fee": 200,
          "drivy_fee": 820
        }

        expect(commission_service.call).to eq(commissions_hash)
      end
    end
  end
end
