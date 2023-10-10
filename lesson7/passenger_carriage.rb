require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(seats)
    @type = :passenger
    @seats_total = seats.to_i
    @seats_used = 0
  end

  def take_seats
    if @seats_total == @seats_used
      raise ArgumentError, "No vacant tables"
    else
      @seats_used += 1
    end
  end
end