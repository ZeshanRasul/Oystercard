class Journey
  attr_reader :in_journey, :entry_station, :exit_station, :journey_details, :journey_fare

  def initialize
    @journey_fare = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    if @in_journey
      @entry_station = "no touch out"
      journey_complete
      @in_journey = false
    else
      @entry_station = station
      @in_journey = true
    end
  end

  def journey_complete
    @journey_details = { start: @entry_station, end: @exit_station }
    fare
  end

  def end_journey(station)
    if @in_journey == true
      @exit_station = station
      @in_journey = false
      journey_complete
    else
      @entry_station = "no touch in"
      @in_journey = false
      @exit_station = station
      journey_complete
    end
  end

  def fare
    # if @journey_details.has_value?('no touch in') || @journey_fare.has_value?('no touch out')
    #   @journey_fare = Oystercard::PENALTY_FARE
    # else
    #   @journey_fare = Oystercard::MINIMUM_FARE
    # end
    @in_journey ? @journey_fare = Oystercard::PENALTY_FARE : @journey_fare = Oystercard::MINIMUM_FARE
  end

end
