# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  extend Accessors
  include Validation

  validate :number, :presence
  validate :number, :format, TRAIN_FORMAT_NUMBER

  def initialize(number)
    super(number)
    @type = 'passenger'
  end
end
