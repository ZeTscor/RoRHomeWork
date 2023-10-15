# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(capacity)
    super(:cargo, capacity)
  end

  def take_capacity(use_capacity)
    raise ArgumentError, 'No volume left' if (free_place - use_capacity).negative?

    @used_place += use_capacity
  end
end
