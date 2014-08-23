class PathCalculator < Struct.new(:origin, :destination)
  attr_reader :paths

  def calculate
    @paths = [Path.new([origin])]

    while !arrived?
      @paths = @paths.map do |path|
        path.walk
      end.flatten
    end
  end

  private

  def arrived?
    @paths.select { |path| path.contains? destination }.any?
  end
end