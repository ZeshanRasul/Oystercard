require 'Oystercard'

describe Oystercard do
  subject(:Oystercard){described_class.new}
  let(:entry_station){ double :entry_station }
  it { is_expected. to respond_to{:balance}}


  describe '#top up' do


    it {is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'top up cannot allow balance to exceed £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{subject.top_up(1)}.to raise_error "Balance has exceeded limit of #{maximum_balance}"
    end

  end
  describe 'journey' do
  let(:entry_station){ double :entry_station }

    it 'in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'lets you touch in' do
      subject.top_up 10
      subject.touch_in(entry_station)
      expect(subject.touch_in(entry_station)).to eq entry_station
    end

    it 'lets you touch out' do
      subject.top_up 10
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end



  describe 'journey charge' do
    let(:entry_station){ double :entry_station }

    it 'charges for your journey on touch out' do

      # allow(subject).to receive(:touch_in) {entry_station}
      subject.top_up 10
      subject.touch_in(entry_station)
      expect{ subject.touch_out }.to change{subject.balance}.by(-1)
    end
  end

  describe 'insufficient balance error on touch in' do
    let(:entry_station){ double :entry_station }

    mininum_balance = Oystercard::MINIMUM_BALANCE
    it 'insufficient balance if less than #{mininum_balance}' do
      insufficient_funds = mininum_balance - 1
      subject.top_up(insufficient_funds)
      # allow(subject).to receive(:touch_in) {entry_station}
      expect{subject.touch_in(entry_station)}.to raise_error "Insufficient balance"
    end
  end






end
