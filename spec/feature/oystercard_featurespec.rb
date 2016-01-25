require 'oystercard'

describe 'feature_test' do
  it 'Tops up oystercard' do
    card = Oystercard.new
    amount = 20
    card.top_up(amount)
    expect(card.balance).to eq amount
  end

  it 'Stops you putting too much money on your card' do
    card = Oystercard.new
    amount = 91
    expect{card.top_up(amount)}.to raise_error("Exceeded max balance of #{Oystercard::MAX_BALANCE}!")
  end
end
