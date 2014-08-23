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
      expect(path_calculator.paths.size).to eql(6)
    end

    it "sets paths from Victoria" do
      last_station_names = path_calculator.paths.map(&:last_station_name)
      expect(last_station_names).to include("Sloane Square")
      expect(last_station_names).to include("Green Park")
      expect(last_station_names).to include("Pimlico")
      expect(last_station_names).to include("St. James's Park")
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

    it "sets 14 paths" do
      expect(path_calculator.paths.size).to eql(14)
    end

    it "sets 3 level paths" do
      path_calculator.paths.each do |path|
        expect(path.size).to eql(3)
      end
    end
  end
end