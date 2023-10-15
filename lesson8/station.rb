# frozen_string_literal: true

class Station
  include InstanceCounter

  STATION_NAME_FORMAT = /^[a-zA-Z\d]+$/.freeze
  attr_reader :name, :trains

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all.push(self)
    register_instance
  end

  def accept_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def each_train(&block)
    @trains.each(&block)
  end

  protected

  def validate!
    raise "Name can't be nil" if name.nil?
    raise 'Station name does not match the pattern a-Z or numbers' if name !~ STATION_NAME_FORMAT
  end
end
