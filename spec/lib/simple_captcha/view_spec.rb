require_relative '../../../lib/simple_captcha/view'

describe SimpleCaptcha::ViewHelper do
  let(:view) do
    Class.new do
      include SimpleCaptcha::ViewHelper
    end
  end

  before do
    module SimpleCaptcha
      def self.length
        6
      end
    end
  end

  describe "generate_simple_captcha_data" do
    context "when 'numeric'" do
      it "generates numbers" do
        expect(view.new.send(:generate_simple_captcha_data, 'numeric')).to match /^\d+$/
      end
    end

    context "when 'distinguishable'" do
      it "generates characters that are easy to recognize" do
        charset = '234679ABCEFGHJLMNPQRTUVWYZ'
        expect(view.new.send(:generate_simple_captcha_data, 'distinguishable')).to match /^[#{charset}]+$/
      end
    end

    context "default" do
      it "generates letters and numbers" do
        expect(view.new.send(:generate_simple_captcha_data, '')).to match /^\w+$/
      end
    end
  end
end
