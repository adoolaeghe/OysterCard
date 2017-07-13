class Journey
  attr_reader :fare, :penalty, :complete
  def initialize
    @entry_station = nil
    @exit_station = nil
    @fare = 1
    @penalty = 6
    @complete = nil
  end

  def complete_journey
    @complete = true if completed?
  end

  def completed?
    entry_station != nil && exit_station != nil
  end

  def begin_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    @end_station= station
  end
end
