require "./spec/spec_helper"

describe PathCalculator do
  context "when calculating path between Victoria and Sloane Square" do
    before :all do
      @path_calculator = PathCalculator.new("Victoria", "Sloane Square")
      @path_calculator.calculate
    end

    it "sets 6 paths" do
      paths = @path_calculator.all_paths

      expect(paths.size).to eql 6
      
      steps = paths.map(&:steps).map { |step| step.map { |s| [s.line.to_i, s.name] } }

      expect(steps).to include [[0, "Victoria"], [3, "Sloane Square"]]
      expect(steps).to include [[0, "Victoria"], [4, "Sloane Square"]]
      expect(steps).to include [[0, "Victoria"], [11, "Pimlico"]]
      expect(steps).to include [[0, "Victoria"], [3, "St. James's Park"]]
      expect(steps).to include [[0, "Victoria"], [4, "St. James's Park"]]
      expect(steps).to include [[0, "Victoria"], [11, "Green Park"]]
    end

    it "returns shortest path from origin to destination" do
      steps = @path_calculator.parsed_shortest_path

      expect(steps).to eql([[0, "Victoria"], [3, "Sloane Square"]])
    end
  end

  context "when calculating path between Victoria and Westminster" do
    before :all do
      @path_calculator = PathCalculator.new("Victoria", "Westminster")
      @path_calculator.calculate
    end

    it "sets 10 paths" do
      paths = @path_calculator.all_paths

      steps = paths.map(&:steps).map { |step| step.map { |s| [s.line.to_i, s.name] } }

      expect(steps.size).to eql(10)
      expect(steps).to include [[0, "Victoria"], [3, "Sloane Square"], [3, "South Kensington"]]
      expect(steps).to include [[0, "Victoria"], [3, "St. James's Park"], [3, "Westminster"]]

      expect(steps).to include [[0, "Victoria"], [4, "Sloane Square"], [4, "South Kensington"]]
      expect(steps).to include [[0, "Victoria"], [4, "St. James's Park"], [4, "Westminster"]]

      expect(steps).to include [[0, "Victoria"], [11, "Green Park"], [7, "Bond Street"]]
      expect(steps).to include [[0, "Victoria"], [11, "Green Park"], [7, "Westminster"]]

      expect(steps).to include [[0, "Victoria"], [11, "Green Park"], [10, "Hyde Park Corner"]]
      expect(steps).to include [[0, "Victoria"], [11, "Green Park"], [10, "Picadilly Circus"]]
      expect(steps).to include [[0, "Victoria"], [11, "Green Park"], [11, "Oxford Circus"]]

      expect(steps).to include [[0, "Victoria"], [11, "Pimlico"], [11, "Vauxhall"]]
    end

    it "returns shortest path from origin to destination" do
      steps = @path_calculator.parsed_shortest_path

      expect(steps).to eql([[0, "Victoria"], [3, "St. James's Park"], [3, "Westminster"]])
    end
  end

  context "when calculating path between Victoria and Knightsbridge" do
    before :all do
      @path_calculator = PathCalculator.new("Victoria", "Knightsbridge")
      @path_calculator.calculate
    end

    it "sets 20 paths" do
      paths = @path_calculator.all_paths

      steps = paths.map(&:steps).map { |step| step.map { |s| [s.line.to_i, s.name] } }

      expect(steps.size).to eql(20)
      expect(steps).to      include [[0, "Victoria"], [3, "Sloane Square"],    [3, "South Kensington"], [3, "Gloucester Road"]]
      expect(steps).to      include [[0, "Victoria"], [3, "Sloane Square"],    [3, "South Kensington"], [10, "Knightsbridge"]]

      expect(steps).to      include [[0, "Victoria"], [3, "St. James's Park"], [3, "Westminster"], [3, "Embankment"]]
      expect(steps).to_not  include [[0, "Victoria"], [3, "St. James's Park"], [3, "Westminster"], [7, "Green Park"]]
      expect(steps).to      include [[0, "Victoria"], [3, "St. James's Park"], [3, "Westminster"], [7, "Waterloo"]]

      expect(steps).to      include [[0, "Victoria"], [4, "Sloane Square"],    [4, "South Kensington"], [4, "Gloucester Road"]]
      expect(steps).to      include [[0, "Victoria"], [4, "Sloane Square"],    [4, "South Kensington"], [10, "Knightsbridge"]]

      expect(steps).to_not  include [[0, "Victoria"], [4, "St. James's Park"], [4, "Westminster"],    [7, "Green Park"]]  
      expect(steps).to      include [[0, "Victoria"], [4, "St. James's Park"], [4, "Westminster"],      [7, "Waterloo"]]
      expect(steps).to      include [[0, "Victoria"], [4, "St. James's Park"], [4, "Westminster"],      [4, "Embankment"]]

      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [7, "Bond Street"],      [2, "Marble Arch"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [7, "Bond Street"],      [7, "Baker Street"]]
      expect(steps).to_not  include [[0, "Victoria"], [11, "Green Park"],      [7, "Bond Street"],      [2, "Oxford Circus"]]
      
      expect(steps).to_not  include [[0, "Victoria"], [11, "Green Park"],      [7, "Westminster"],      [3, "St. James's Park"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [7, "Westminster"],      [3, "Embankment"]]
      expect(steps).to_not  include [[0, "Victoria"], [11, "Green Park"],      [7, "Westminster"],      [4, "St. James's Park"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [7, "Westminster"],      [4, "Embankment"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [7, "Westminster"],      [7, "Waterloo"]]

      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [10, "Hyde Park Corner"], [10, "Knightsbridge"]]

      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [10, "Picadilly Circus"], [1, "Charing Cross"]]
      expect(steps).to_not  include [[0, "Victoria"], [11, "Green Park"],      [10, "Picadilly Circus"], [1, "Oxford Circus"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [10, "Picadilly Circus"], [10, "Leicester Square"]]

      expect(steps).to_not  include [[0, "Victoria"], [11, "Green Park"],      [11, "Oxford Circus"],    [1, "Picadilly Circus"]]

      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [11, "Oxford Circus"],    [1, "Regent's Park"]]
      expect(steps).to_not  include [[0, "Victoria"], [11, "Green Park"],      [11, "Oxford Circus"],    [2, "Bond Street"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [11, "Oxford Circus"],    [2, "Tottenham Court Road"]]
      expect(steps).to      include [[0, "Victoria"], [11, "Green Park"],      [11, "Oxford Circus"],    [11, "Warren Street"]]

      expect(steps).to      include [[0, "Victoria"], [11, "Pimlico"],         [11, "Vauxhall"],          [11, "Stockwell"]]
    end

    it "returns shortest path from origin to destination" do
      steps = @path_calculator.parsed_shortest_path

      expect(steps).to eql([[0, "Victoria"], [3, "Sloane Square"], [3, "South Kensington"], [10, "Knightsbridge"]])
    end
  end

  context "when calculating path between Victoria and West Brompton" do
    before :all do
      @path_calculator = PathCalculator.new("Victoria", "West Brompton")
      @path_calculator.calculate
    end

    it "returns shortest path from origin to destination" do
      steps = @path_calculator.parsed_shortest_path
      
      expect(steps).to eql([[0, "Victoria"], [4, "Sloane Square"], [4, "South Kensington"], 
                                          [4, "Gloucester Road"], [4, "Earl's Court"], [4, "West Brompton"]])
    end
  end
end