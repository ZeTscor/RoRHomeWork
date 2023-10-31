# frozen_string_literal: true

class Route
  extend Accessors
  include Validation
  include InstanceCounter
  attr_reader :stations

  validate :stations, :type, Station

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def self.all
    @@all
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end
end
