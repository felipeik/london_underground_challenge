class PathCalculator < Struct.new(:origin, :destination)
  attr_reader :paths

  def calculate
    origin_path = Path.new([origin])

    calculated_paths = []

    last_station = origin_path.last_station

    last_station.lines.each do |line|
      new_path = Path.new(origin_path.station_path)
      next_station = line.next_station_from(last_station)

      new_path.add_station(next_station)
      calculated_paths << new_path
    end

    @paths = calculated_paths
  end
end