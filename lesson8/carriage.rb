# frozen_string_literal: true

require_relative 'factory'

class Carriage
  include Factory

  attr_reader :type

  def initialize(type, total_place)
    @type = type
    @total_place = total_place
    @used_place = 0
  end

  def free_place
    @total_place - @used_place
  end
end
