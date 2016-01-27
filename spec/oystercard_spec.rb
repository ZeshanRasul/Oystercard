require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  subject(:oystercard) { described_class.new }

  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up the oystercard by the amount passed in' do
      expect{oystercard.top_up(5)}.to change{oystercard.balance}.by 5
    end

    it 'raises an error if the user tries to exceed the maximum balance' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect{oystercard.top_up(1)}.to raise_error "You may not exceed £#{Oystercard::MAX_BALANCE}"
    end
  end

  describe '#touch_in' do
    context 'oystercard is topped up' do
      before do
        oystercard.top_up(1)
      end

    end

    context 'when balance is under £1' do
      it 'raises an error' do
        expect{oystercard.touch_in(entry_station)}.to raise_error 'Balance is too low'
      end
    end
  end

  context 'oystercard is touched in' do

    before do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
    end

    describe '#touch_out' do


      it 'deducts the minimum amount' do
        expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Oystercard::MIN_FARE)
      end
    end
  end

end
