class Line < Struct.new(:station1_id, :station2_id, :line)
  def self.all
    @all ||= []
  end

  def self.create(station1_id, station2_id, line)
    all << Line.new(station1_id, station2_id, line)
  end

  def self.by_station(station)
    all.select { |line| line.station1 == station || line.station2 == station  }
  end

  def self.by_stations(station_a, station_b)
    all.select { |line| (line.station1 == station_a || line.station2 == station_a) && 
                        (line.station1 == station_b || line.station2 == station_b) }
  end

  def station1
    Station.find(station1_id)
  end

  def station2
    Station.find(station2_id)
  end

  def next_station_from(station)
    if station == station1
      station2
    elsif station == station2
      station1
    else
      raise "No station for this line"
    end
  end

  def station_names
    [station1.name, station2.name]
  end
end