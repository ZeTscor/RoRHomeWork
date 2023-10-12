require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(capacity, number)
    super(:cargo, number, capacity)
  end

  def take_capacity(use_capacity)
    raise ArgumentError, "No volume left" if free_place - use_capacity < 0
    @used_place += use_capacity
  end
end


