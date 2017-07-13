class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = MIN_BALANCE
  attr_reader :balance, :entry_station, :journeys
  def initialize(balance = 0)
    @balance = balance.to_f
    @in_journey = false
    @journeys = []
  end

  def top_up(money)
    fail "top up failed the money exceeds #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(location)
    fail "touch in failed: the balance is lower than #{MIN_BALANCE}" if balance < MIN_BALANCE
    @entry_station = location
  end

  def touch_out(location)
    (@entry_station = nil; fail 'No journeys have been stored') if location == entry_station
    @journeys << {entry_station => location}
    @entry_station = nil
    deduct(MIN_FARE)
  end

  def in_journey?
    @entry_station != nil
  end

end
