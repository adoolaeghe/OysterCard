class Station
  attr_reader :zone, :name
  def initialize(name, zone)
    fail "the zone doesn't exist" if zone > 7 || zone < 0
    @name = name
    @zone = zone
  end
end
