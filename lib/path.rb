class Path
  def initialize(steps = [])
    @steps = steps
  end

  def size
    steps.size
  end

  def steps
    @steps.dup
  end

  def add_step(line, station)
    @steps << Step.new(line, station)
  end

  def last_step
    @steps.last
  end

  def last_station
    last_step.station
  end

  def steps_name
    @steps.last.name
  end

  def visited_stations
    @steps.map(&:station).uniq
  end

  def walk(options = {})
    skip_stations = options[:visited_stations]

    new_paths = []

    self.last_step.lines.each do |line|
      new_path = Path.new(self.steps)
      next_station = line.next_station_from(last_station)

      next if new_path.contains? next_station

      last_line = last_step.line
      next_line = line.line
      next if should_change_line? last_line, next_line, last_station, next_station

      next if skip_station? skip_stations, next_station

      new_path.add_step(line.line,next_station)
      new_paths << new_path
    end

    new_paths
  end

  def skip_station? skip_stations, next_station
    skip_stations.include? next_station if skip_stations
  end

  def contains? station
    @steps.map(&:station).include? station
  end

  def should_change_line? last_line, next_line, last_station, next_station
    lines = Line.by_stations(last_station, next_station)

    should_change = (last_line != next_line && lines.map(&:line).include?(last_line))
    should_change
  end

  def line_changes
    last_line = steps.first.line

    changes = -1
    steps.each do |step|
      changes = changes + 1 if step.line != last_line
      last_line = step.line
    end
    changes
  end

  class Step < Struct.new(:line, :station)
    def lines
      station.lines
    end

    def name
      station.name
    end
  end
end