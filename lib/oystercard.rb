class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = MIN_BALANCE
  attr_reader :balance, :journeys
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

  def touch_in(station)
    fail "touch in failed: the balance is lower than #{MIN_BALANCE}" if balance < MIN_BALANCE
    deduct(penalty) if in_journey?
    @journeys << create_journey
  end

  def touch_out(station)
    fail 'No journeys have been stored' if station == entry_station

    @entry_station = nil
    deduct(MIN_FARE)
  end

  def create_journey
    Journey.new
  end

  def in_journey?
    @entry_station != nil
  end
end

require './lib/oystercard.rb'
require './lib/station.rb'
require './lib/journey.rb'

mycard = Oystercard.new
aldgate = Station.new('aldate',1)
liverpool = Station.new('liverpool',1)
mycard.top_up(10)
