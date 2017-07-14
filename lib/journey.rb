class Journey
  attr_reader :fare, :penalty, :entry_station
  def initialize
    @entry_station = nil
    @exit_station = nil
    @fare = 1
    @penalty = 6
  end

  def completed?
    @exit_station != nil || @entry_station != nil
  end

  def begin_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
  end
end
