class Oystercard

  attr_reader :balance, :in_journey, :station_in

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end


  def top_up(amount)
    fail "Exceeded max balance of #{MAX_BALANCE}!" if max_balance?(amount)
    @balance += amount
  end

  def touch_in(station_in)
    fail "Please top up your Oystercard" if top_up_needed?
    @in_journey = true unless in_journey?
    @station_in = station_in
  end

  def touch_out
    @in_journey = false if in_journey?
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end

private

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end

  def deduct(fare)
    @balance -= fare
  end

  def top_up_needed?
    @balance <= MINIMUM_BALANCE
  end

end
