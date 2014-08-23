class PathCalculator < Struct.new(:origin, :destination)
  attr_reader :paths

  def calculate
    first_path = Path.new
    first_path.add_step 0, origin
    @paths = [first_path]

    while !arrived?
      @paths = @paths.map do |path|
        visited_stations = @paths.map(&:visited_stations).flatten.uniq
        path.walk(visited_stations: visited_stations)
      end.flatten
    end
  end

  private

  def arrived?
    @paths.select { |path| path.contains? destination }.any?
  end
end