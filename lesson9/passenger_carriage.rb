# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(seats)
    super(:passenger, seats)
  end

  def take_seats
    raise ArgumentError, 'No seats left' if (free_place - 1).negative?

    @used_place += 1
  end
end
