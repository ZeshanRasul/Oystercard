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
    expect{card.top_up(Oystercard::MAX_BALANCE)}.to raise_error("Exceeded max balance of #{Oystercard::MAX_BALANCE}!")
  end

  it 'deducts money from oystercard' do
    card = Oystercard.new
    fare = 2
    card.top_up(amount)
    expect(card.deduct(fare)).to eq 18
  end

  it 'deducts money from oystercard when touching out'
    card = Oystercard.new
    fare = 2
    station_in = :Peckham
    card.top_up(20)
    card.touch_in(station_in)
    card.touch_out
    expect(card.balance).to eq 18
  end

  it 'lets you retrieve the name of the station you touched in at'
    card = Oystercard.new
    fare = 2
    station_in = :Peckham
    card.top_up(20)
    card.touch_in(station_in)
    expect(card.station_in).to eq station_in
  end

end
