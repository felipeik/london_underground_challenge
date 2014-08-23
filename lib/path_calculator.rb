class PathCalculator
  attr_reader :all_paths, :origin, :destination

  def initialize(origin_name, destination_name)
    @origin = Station.find_by_name(origin_name)
    @destination = Station.find_by_name(destination_name)
  end

  def calculate
    first_path = Path.new
    first_path.add_step 0, origin
    @all_paths = [first_path]

    while !arrived?
      @all_paths = all_paths.map do |path|
        visited_stations = all_paths.map(&:visited_stations).flatten.uniq
        path.walk(visited_stations: visited_stations)
      end.flatten
    end

    @calculated = false
  end

  def shortest_path
    calculate if !@calculated
    possible_paths.sort { |last,current| last.line_changes <=> current.line_changes }.first
  end

  def parsed_shortest_path
    shortest_path.readable_steps
  end

  private

  def possible_paths
    all_paths.select { |path| path.last_station == destination }
  end

  def arrived?
    self.all_paths.select { |path| path.contains? destination }.any?
  end
end