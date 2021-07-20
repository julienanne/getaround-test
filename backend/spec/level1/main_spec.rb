require_relative '../../level1/main'

RSpec.describe "Main" do
  describe "can execute" do
    context "with Hello" do
      it "return Hello on stdout" do
        sentence_regex = /^Hello\n$/
        expect { execute(["Hello"]) }.to output(sentence_regex).to_stdout
      end
    end
  end
end
