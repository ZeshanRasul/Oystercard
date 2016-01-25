class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
 attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

   def in_journey?
     @in_journey
   end

  def touch_in
    fail "Insufficient balance" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @balance -= MINIMUM_BALANCE
    @in_journey = false
  end

  private

  def deduct amount
    @balance -= amount
  end

end
