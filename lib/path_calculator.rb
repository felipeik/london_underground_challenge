class PathCalculator < Struct.new(:origin, :destination)
  attr_reader :all_paths

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
  end

  def path
    all_paths.select { |path| path.last_station == destination }.first
  end

  private

  def arrived?
    self.all_paths.select { |path| path.contains? destination }.any?
  end
end