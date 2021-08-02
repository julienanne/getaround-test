require_relative "../../services/actions"

RSpec.describe Actions, "object" do
  context "can actions for a rental" do
    describe "call" do
      it "rental price 3000" do
        commissions_hash = {
          insurance_fee: 450,
          assistance_fee: 100,
          drivy_fee: 350
        }

        options_hash = {
          owner: 700,
          drivy: 0
        }

        actions = [
        {
          who: "driver",
          type: "debit",
          amount: 3700
        },
        {
          who: "owner",
          type: "credit",
          amount: 2800
        },
        {
          who: "insurance",
          type: "credit",
          amount: 450
        },
        {
          who: "assistance",
          type: "credit",
          amount: 100
        },
        {
          who: "drivy",
          type: "credit",
          amount: 350
        }
      ]

        expect(Actions.call(rental_price_discounted: 3000, commission_parts: commissions_hash, options_parts: options_hash)).to eq(actions)
      end

      it "rental price 6800" do
        commissions_hash = {
          insurance_fee: 1020,
          assistance_fee: 200,
          drivy_fee: 820
        }

        options_hash = {
          owner: 0,
          drivy: 2000
        }

        actions = [
          {
            who: "driver",
            type: "debit",
            amount: 8800
          },
          {
            who: "owner",
            type: "credit",
            amount: 4760
          },
          {
            who: "insurance",
            type: "credit",
            amount: 1020
          },
          {
            who: "assistance",
            type: "credit",
            amount: 200
          },
          {
            who: "drivy",
            type: "credit",
            amount: 2820
          }
        ]

        expect(Actions.call(rental_price_discounted: 6800, commission_parts: commissions_hash, options_parts: options_hash)).to eq(actions)
      end
    end
  end
end
