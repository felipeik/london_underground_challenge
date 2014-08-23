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

  def walk
    new_paths = []
    
    self.last_station.lines.each do |line|
      new_path = Path.new(self.station_path)
      next_station = line.next_station_from(last_station)

      next if new_path.contains? next_station
      new_path.add_station(next_station)
      new_paths << new_path
    end

    new_paths
  end

  def contains? station
    @station_path.include? station
  end
end