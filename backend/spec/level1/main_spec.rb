require_relative '../../level1/main'

RSpec.describe "Main" do
  describe "can execute" do
    context "for level1" do
      it "create a File named data/output.json" do
        execute

        expect(File).to exist("./level1/data/output.json")
      end
    end
  end
end
