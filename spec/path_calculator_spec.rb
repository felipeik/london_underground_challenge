require "./spec/spec_helper"

describe PathCalculator do
  context "when calculating path between Victoria and Sloane Square" do
    let(:station1) { Station.find_by_name("Victoria") }
    let(:station2) { Station.find_by_name("Sloane Square") }

    let(:path_calculator) { PathCalculator.new(station1, station2) }

    before do
      path_calculator.calculate
    end

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

    it "sets 2 level paths" do
      path_calculator.paths.each do |path|
        expect(path.size).to eql(2)
      end
    end
  end

  context "when calculating path between Victoria and Westminster" do
    let(:station1) { Station.find_by_name("Victoria") }
    let(:station2) { Station.find_by_name("Westminster") }

    let(:path_calculator) { PathCalculator.new(station1, station2) }

    before do
      path_calculator.calculate
    end

    it "sets 11 paths" do
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

    it "sets 3 level station paths" do
      path_calculator.paths.each do |path|
        expect(path.size).to eql(3)
      end
    end

    it "sets 3 level station paths with line changes" do
      path_calculator.paths.each do |path|
        expect(path.size).to eql(3)
      end
    end
  end
end