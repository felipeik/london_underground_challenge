require "CSV"
require "pry"
require "./lib/route"
require "./lib/line"
require "./lib/station"
require "./lib/path"
require "./lib/path_calculator"

line = 0
CSV.parse(File.read("./data/routes.csv")) do |row|
  line = line + 1
  next if line == 1
  Route.create(row[0], row[1], row[2], row[3])
end

line = 0
CSV.parse(File.read("./data/lines.csv")) do |row|
  line = line + 1
  next if line == 1
  Line.create(row[0], row[1], row[2])
end

line = 0
CSV.parse(File.read("./data/stations.csv")) do |row|
  line = line + 1
  next if line == 1
  Station.create(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7])
end