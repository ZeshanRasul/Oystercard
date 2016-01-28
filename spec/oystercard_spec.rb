require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topup_amount) {5}
  let(:random_topup_amount) {rand(1..20)}
  let(:too_large_topup) {91}
  let(:station) { double :station}
  let(:station) { double :station}
  let(:station) {double :station}
  let(:journey) {double :journey}

  describe "#initialize" do

    it {is_expected.to respond_to(:balance)}

    it "has an initial balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    # it {is_expected.to respond_to(:in_journey?)}

    it 'has an empty list of journeys by default' do
      expect(oystercard.journey_hist).to eq []
    end

    it 'creates a new instance of current journey to be nil' do
      expect(oystercard.this_journey).to eq nil
    end

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

  describe "#touch_in" do
    #
    # before do
    #   oystercard.top_up(topup_amount)
    # end

    # it "returns true to #in_journey when you touch in" do
    #   expect {oystercard.touch_in(station)}.to change(oystercard, :in_journey?).from(false).to(true)
    # end

    # it "returns true when in_journey?" do
    #   oystercard.touch_in(station)
    #   expect(oystercard.in_journey?).to be_truthy
    # end

    context "Cannot have less than £#{Oystercard::MINIMUM_BALANCE}" do
      #
      # before do
      #   4.times do
      #     oystercard.touch_in(station)
      #     oystercard.touch_out(station)
      #   end
      # end

      it "Will raise error 'Please top up your Oystercard'" do
        expect{oystercard.touch_in(station)}.to raise_error "Please top up your Oystercard"
      end

    end

    context "#touch_in remembers the station you touched in at" do
      let(:journey) {double :journey}

      before do
        oystercard.top_up(topup_amount)
      end
      #
      # it "Will return name of station touched in at" do
      #   expect(oystercard.touch_in(station)).to eq station
      # end
      #
      # it "Will let you store the name of the station you touched in at" do
      #   oystercard.touch_in(station)
      #   expect(oystercard.station).to eq station
      # end
      it 'creates a new instance of the journey class if it doesn\'t already exist' do
        oystercard.touch_in(station)
        expect(oystercard.this_journey).not_to eq nil
      end
    end

  end

  describe "#touch out" do

    # context "Changing card status to be not #in_journey?" do
      let(:station) { double :station}
      let(:journey) {double :journey}
      # before do
      #   oystercard.top_up(topup_amount)
      #   oystercard.touch_in(station)
      # end

      # it "returns false to #in_journey? when you touch in" do
      #   expect {oystercard.touch_out(station)}.to change(oystercard, :in_journey?).from(true).to(false)
      # end

      # it "return false when touched out" do
      #   oystercard.touch_out(station)
      #   expect(oystercard.in_journey?).to be_falsey
      # end

      it "deducts fare when touched out" do
        oystercard.instance_variable_set("@balance", 2)
        oystercard.touch_in(station)
        expect {oystercard.touch_out(station)}.to change{oystercard.balance}.by(-1)
        #Oystercard::MINIMUM_FARE)
      end




    # context "#touch_out will cause the entry station to be forgotten" do
    #
    #   it "Returns nil for station when touched out" do
    #     oystercard.touch_out(station)
    #     expect(oystercard.station).to be_nil
    #   end



  end

  describe 'saving journey history' do
    let(:journey_hash) { {start: station, end: station}}
    let(:journey) {double :journey}
    it 'saves one journey after touching in and out' do
      oystercard.top_up 10
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.journey_hist).to include journey_hash
    end
  end


end
