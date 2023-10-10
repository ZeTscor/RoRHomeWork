require_relative 'factory'

class Carriage
  include Factory

  attr_reader :type

  def initialize(type)
    @type = type
  end
end