require 'Oystercard'

describe Oystercard do

  it { is_expected. to respond_to{:balance}}

  describe 'top up' do


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

  describe 'deduct method' do
    it 'deduct' do
      subject.top_up 50
      expect{ subject.deduct 50 }.to change{ subject.balance }.by -50
    end
  end

  describe 'insufficient balance error on touch in' do
    mininum_balance = Oystercard::MINIMUM_BALANCE
    it 'insufficient balance if less than #{mininum_balance}' do
      insufficient_funds = mininum_balance - 1
      subject.top_up(insufficient_funds)
      expect{subject.touch_in}.to raise_error "Insufficient balance"
    end
  end



end
