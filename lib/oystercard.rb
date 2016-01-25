class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
 attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    fail "Insufficient balance" if balance < MINIMUM_BALANCE
    # @in_journey = true
    entry_station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = nil
  end

  private

  def deduct amount
    @balance -= amount
  end

end
