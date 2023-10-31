# frozen_string_literal: true
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attribute, validation_type, *options)
      validations << { attribute:, validation_type:, options: }
    end

    def validations
      @validations ||= []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = validation[:attribute]
        validation_type = validation[:validation_type]
        options = validation[:options]

        valid = send(attribute)

        case validation_type
        when :presence
          raise "#{attribute} cannot be empty" unless presence_valid?(valid)
        when :format
          raise "#{attribute} format is not correct, enter in English without numbers" unless format_valid?(valid, options[0])
        when :type
          raise "#{attribute} must be a type #{options[0]}" unless type_valid?(valid, options[0])
        end
      end
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def presence_valid?(value)
      !value.nil? && !value.to_s.empty?
    end

    def format_valid?(value, regex)
      !value.to_s.match(regex).nil?
    end

    def type_valid?(value, type)
      value.is_a?(type)
    end
  end
end
