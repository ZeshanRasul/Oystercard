require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topup_amount) {5}
  let(:random_topup_amount) {rand(1..20)}
  let(:too_large_topup) {91}
  let(:set_fare) {2}

  describe "#initialize" do

    it {is_expected.to respond_to(:balance)}

    it "has an initial balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it {is_expected.to respond_to(:in_journey?)}

  end

  describe "#top_up" do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it "Adds set top-up amount to balance" do
      expect(oystercard.top_up(topup_amount)).to eq (oystercard.balance)
    end

    it "Adds random top-up amount to balance" do
      expect(oystercard.top_up(random_topup_amount)).to eq (oystercard.balance)
    end

    context "top up with max balance" do

      it "raises error if max balance is exceeded" do
        expect{oystercard.top_up(too_large_topup)}.to raise_error "Exceeded max balance of #{Oystercard::MAX_BALANCE}!"
      end

    end

  end

  describe "#deduct(fare)" do

    it{is_expected.to respond_to(:deduct).with(1).argument}

    before do
      oystercard.top_up(topup_amount)
    end

    it "Will deduct the fare from the oystercard balance" do
      expect(oystercard.deduct(set_fare)).to eq oystercard.balance
    end

  end

  describe "#touch_in" do

    before do
      oystercard.top_up(topup_amount)
    end

    it "touches in makes card in_journey" do
      expect {oystercard.touch_in}.to change(oystercard, :in_journey).from(false).to(true)
    end

    it "returns true when in_journey?" do
      oystercard.touch_in
      expect(oystercard.in_journey?).to be_truthy
    end

    context "Cannot have less than £#{Oystercard::MINIMUM_BALANCE}" do

      before do
        2.times {oystercard.deduct(set_fare)}
      end

      it "Will raise error 'Please top up your Oystercard'" do
        expect {oystercard.touch_in}.to raise_error "Please top up your Oystercard"
      end

    end
  end

  describe "#touch out" do

    it "touches out makes card not in_journey" do
      expect(oystercard.touch_out).not_to eq oystercard.in_journey
    end

    it "return false when touched out" do
      oystercard.touch_out
      expect(oystercard.in_journey).to be_falsey
    end

  end

end
