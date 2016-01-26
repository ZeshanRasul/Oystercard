require 'station'

describe Station do
  let(:name) { double :name}
  let(:zone) { double :zone}
  subject(:station) {described_class.new(:name,:zone)}

  describe "#initialize" do

    it {is_expected.to respond_to(:name)}

    it {is_expected.to respond_to(:zone)}

  end

end
