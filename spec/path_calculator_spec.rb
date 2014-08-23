require "./spec/spec_helper"

describe PathCalculator do
  let(:path_calculator) { PathCalculator.new(origin, destination) }

  before do
    path_calculator.calculate
  end

  context "when calculating path between Victoria and Sloane Square" do
    let(:origin) { Station.find_by_name("Victoria") }
    let(:destination) { Station.find_by_name("Sloane Square") }

    it "sets 6 paths" do
      paths = path_calculator.paths

      expect(paths.size).to eql 6
      
      steps = paths.map(&:steps).map { |step| step.map { |s| [s.line.to_i, s.name] } }

      expect(steps).to include [[0, "Victoria"], [3, "Sloane Square"]]
      expect(steps).to include [[0, "Victoria"], [4, "Sloane Square"]]
      expect(steps).to include [[0, "Victoria"], [11, "Pimlico"]]
      expect(steps).to include [[0, "Victoria"], [3, "St. James's Park"]]
      expect(steps).to include [[0, "Victoria"], [4, "St. James's Park"]]
      expect(steps).to include [[0, "Victoria"], [11, "Green Park"]]
    end
  end

  context "when calculating path between Victoria and Westminster" do
    let(:origin) { Station.find_by_name("Victoria") }
    let(:destination) { Station.find_by_name("Westminster") }

    it "sets 10 paths" do
      paths = path_calculator.paths

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
  end

  context "when calculating path between Victoria and Knightsbridge" do
    let(:origin) { Station.find_by_name("Victoria") }

    let(:destination) { Station.find_by_name("Knightsbridge") }

    it "sets 20? paths" do
      paths = path_calculator.paths

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
  end
end