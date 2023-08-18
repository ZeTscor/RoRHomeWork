class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
end

class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end
end

class Train
  attr_reader :number, :type, :speed, :carriages, :current_station

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def accelerate(speed)
    @speed += speed
  end

  def brake
    @speed = 0
  end

  def attach_carriage
    @carriages += 1 if @speed == 0
  end

  def detach_carriage
    @carriages -= 1 if @speed == 0 && @carriages > 0
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