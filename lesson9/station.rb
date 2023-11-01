# frozen_string_literal: true

class Station
  extend Accessors
  include Validation
  include InstanceCounter

  STATION_NAME_FORMAT = /^[a-zA-Z\d]+$/.freeze
  attr_reader :name, :trains

  attr_accessor_with_history :trains

  validate :name, :presence
  validate :name, :format, STATION_NAME_FORMAT

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
end
