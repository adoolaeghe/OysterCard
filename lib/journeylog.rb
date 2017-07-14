require_relative 'journey'
class JourneyLog
  def initialize
    @journey = Journey.new
  end

  def start(station)
    @journey.begin_journey(station)
  end

  def current_journey
    @journey if @journeys.completed? == false
    @journey.completed? 
  end
end
