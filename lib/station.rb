class Station < Struct.new(:id, :latitude, :longitude, :name, :display_name, :zone, :total_lines, :rails)
  def self.all
    @all ||= []
  end

  def self.create(id, latitude, longitude, name, display_name, zone, total_lines, rails)
    all << Station.new(id, latitude, longitude, name, display_name, zone, total_lines, rails)
  end

  def self.find_by_name(name)
    all.select { |station| station.name == name }.first
  end 

  def self.find(id)
    all.select { |station| id == station.id }.first
  end

  def lines
    Line.all.select { |line| line.station1 == self || line.station2 == self }
  end

  def next_lines_from(station)
    lines.select { |line| line.station1 != station && line.station2 != station }
  end
end