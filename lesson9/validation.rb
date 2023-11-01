# frozen_string_literal: true
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    def validate!
      self.class.instance_variable_get(:@validations).each do |validation|
        var_name = validation[:name]
        method_name = "validate_#{validation[:type].to_s}".to_sym
        if validation[:type] == :presence
          send method_name, var_name
        else
          send method_name, var_name, validation[:param]
        end
      end
    end

    protected

    def validate_presence(name)
      value = instance_variable_get("#{name}".to_sym)
      if value
        if (value.is_a? String) && value.strip == ''
          raise "The value of variable #{name} must NOT be an empty string"
        end
      else
        raise "The value of the variable #{name} must be filled in"
      end
    end

    def validate_type(name, type)
      value = instance_variable_get("#{name}".to_sym)
      unless value.is_a? type
        raise "The value of variable #{name} does not match the specified type #{type.to_s}"
      end
    end

    def validate_format(name, format)
      value = instance_variable_get("#{name}".to_sym)
      unless format.match(value)
        raise "The value of the variable #{name} does not match the format #{format.to_s}"
      end
    end
  end

  module ClassMethods
    def validate(field_name, *args)
      name = "@#{field_name.to_s}"
      unless instance_variable_defined? (:@validations)
        @validations = []
      end
      type = args[0]
      param = args[1]
      if type != :presence && type != :format && type != :type
        raise "Unknown validation type"
      end
      if type == :format && !(param.is_a? Regexp)
        raise "A regular expression must be passed to check the format"
      end
      if type == :type && !(param.is_a? Class)
        raise "To check for a data type, a class must be specified"
      end
      @validations << { name: name, type: type, param: param }
    end
  end
end