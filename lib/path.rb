class Path

  def initialize(station_path = [])
    @station_path = station_path
  end

  def size
    station_path.size
  end

  def station_path
    @station_path.dup
  end

  def add_station(station)
    @station_path << station
  end

  def last_station
    @station_path.last
  end

  def last_station_name
    @station_path.last.name
  end
end