require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(capacity)
    @type = :cargo
    @free_capacity = capacity
    @buse_capacity = 0.0
  end

  def take_capacity(use_capacity)
    if capacity_free - use_capacity < 0
      raise ArgumentError, "No volume left"
    else
      @buse_capacity += use_capacity
    end
  end

  def capacity_free
    @free_capacity - @buse_capacity
  end
end