# frozen_string_literal: true

class Train
  extend Accessors
  include Validation
  include Factory
  include InstanceCounter
  attr_reader :number, :type, :speed, :carriages, :current_station

  @@all = []
  attr_accessor_with_history :route

  TRAIN_FORMAT_NUMBER = /^[a-zA-Z\d]-?[a-zA-Z\d]{2}$/
  validate :number, :format, TRAIN_FORMAT_NUMBER
  validate :number, :presence

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    @@all.push(self)
    register_instance
    validate!
  end

  def self.find(num)
    @@all.select { |train| train.number == num ? train : nil }
  end

  def accelerate(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def attach_carriage(carriage)
    return unless @speed.zero?

    @carriages << carriage
  end

  def detach_carriage(carriage)
    return unless @speed.zero? && @carriages.include?(carriage)

    @carriages.delete(carriage)
  end

  def assign_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.accept_train(self)
  end

  def move_forward
    return unless next_station

    @current_station.send_train(self)
    @current_station = next_station
    @current_station.accept_train(self)
  end

  def move_backward
    return unless previous_station

    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.accept_train(self)
  end

  def previous_station
    return unless @route

    current_index = @route.stations.index(@current_station)
    @route.stations[current_index - 1] if current_index.positive?
  end

  def next_station
    return unless @route

    current_index = @route.stations.index(@current_station)
    @route.stations[current_index + 1] if current_index < @route.stations.size - 1
  end

  def each_train(&block)
    @carriages.each(&block)
  end

end
