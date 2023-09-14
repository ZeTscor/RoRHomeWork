class Train
  attr_reader :number, :type, :speed, :carriages, :current_station

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
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
end