require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize
    @type = :cargo
  end
end