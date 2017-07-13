class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = MIN_BALANCE
  attr_reader :balance, :journeys
  def initialize(balance = 0)
    @balance = balance.to_f
    @in_journey = false
    @journeys = []
    @journey = nil
  end

  def top_up(money)
    fail "top up failed the money exceeds #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(station)
    fail "touch in failed: the balance is lower than #{MIN_BALANCE}" if balance < MIN_BALANCE
    if journeys == []
      add_journey
    else
      deduct(@journey.penalty) if @journey.completed? == false
      add_journey
    end
  end

  def touch_out(station)
    if @journey.completed? == true
      @journey
      deduct(@journey.penalty)
    else
      @journey.end_journey(station)
      @journey.complete_journey
      deduct(MIN_FARE)
    end
  end

  def create_journey(station)
    @journey = Journey.new
    @journey.begin_journey(station)
  end

  def add_journey
    create_journey(station)
    @journeys << @journey
  end
end

require './lib/oystercard.rb'
require './lib/station.rb'
require './lib/journey.rb'

mycard = Oystercard.new
aldgate = Station.new('aldate',1)
liverpool = Station.new('liverpool',1)
mycard.top_up(10)
mycard.touch_in(aldgate)
