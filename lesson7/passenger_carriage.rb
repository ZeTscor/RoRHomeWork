require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(seats)
    super(:passenger, seats)
  end

  def take_seats
    raise ArgumentError, "No seats left" if free_place - 1 < 0
    @used_place += 1
  end
end
