class Oystercard

  attr_reader :balance, :journey_hist, :this_journey

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance=DEFAULT_BALANCE, journey_klass = Journey)
    @balance = balance
    @journey_klass = journey_klass
    @journey_hist = []
    @this_journey = nil
  end


  def top_up(amount)
    fail "Exceeded max balance of #{MAX_BALANCE}!" if max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Please top up your Oystercard" if top_up_needed?
    if @this_journey
      @this_journey.start_journey(station)
      add_to_journey
      deduct(current_fare)
      @this_journey = nil
      touch_in(station)
    else
      @this_journey = @journey_klass.new
      @this_journey.start_journey(station)
    end
  end

  def touch_out(station)
    if @this_journey == nil
      @this_journey = @journey_klass.new
      touch_out(station)
    else
      @this_journey.end_journey(station)
      add_to_journey
      deduct(current_fare)
      @this_journey = nil
    end
  end

private

  def max_balance?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct(fare)
    @balance -= fare
  end

  def top_up_needed?
    @balance <= MINIMUM_BALANCE
  end

  def add_to_journey
    @journey_hist.push(@this_journey.journey_details)
  end

  def current_fare

    @this_journey.journey_fare

  end


end
