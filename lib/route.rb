class Route < Struct.new(:line, :name, :colour, :stripe)
  def self.all
    @all ||= []
  end

  def self.create(line, name, colour, stripe)
    all << Route.new(line, name, colour, stripe)
  end 
end