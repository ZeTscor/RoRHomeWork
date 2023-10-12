require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(seats)
    @type = :passenger
    @seats_total = seats.to_i
    @seats_used = 0
  end

  def take_seats
    raise ArgumentError, "No seats left" if free_place - 1 < 0
    @used_place += 1
  end
end
