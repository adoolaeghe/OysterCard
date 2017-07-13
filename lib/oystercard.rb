require_relative 'station'
require_relative 'journey'

class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :journeys
  def initialize(balance = 0)
    @balance = balance.to_f
    @journeys = []
    @journey = Journey.new
  end

  def top_up(money)
    fail "top up failed the money exceeds #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(station)
    fail "touch in failed: the balance is lower than #{MIN_BALANCE}" if balance < MIN_BALANCE
      deduct(@journey.penalty) if @journey.completed? == true
      create_journey(station)
  end

  def touch_out(station)
    if @journey.completed? != true
      deduct(@journey.penalty)
    else
      @journey.end_journey(station)
      deduct(@journey.fare)
      reset_journey
    end
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def create_journey(station)
    @journey.begin_journey(station)
    @journeys << @journey
  end

  def reset_journey
    @journey= Journey.new
  end
end
