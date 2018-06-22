# frozen_string_literal: true

class Calculator
  # If I were to spend more time, maybe I'd actually migrate in a model. If so,
  # I'd initialize the calculation params, give myself easy access to the array,
  # and separate the various blocks in the `self.calculate` method. For this
  # project keeping it simple (as simple as a full Rails app can be!) seemed
  # best, though.

  def self.calculate(calculation)
    # Split the run-together string into numbers and operands
    @calculation_array = calculation.split(/(\d+)/).drop(1)

    # Calculate higher-precendence operations first and return the appropriate
    # float precision
    @calculation_array.each_with_index do |element, index|
      if /\*|\/|\%/.match? element
        sub_result = perform_calculation(index)
        @calculation_array[(index - 1)..(index + 1)] = sub_result.to_f.round(2)
      end
    end

    # Any digits left in the Array need to be changed to floats
    @calculation_array.each_with_index do |element, index|
      next unless element.is_a? String
      next unless /\d+/.match? element
      @calculation_array[index] = element.to_f
    end

    # Handle subtraction
    @calculation_array.each_with_index do |element, index|
      next unless element.is_a? String
      next unless /\-/.match? element
      sub_result = perform_calculation(index)
      @calculation_array[(index - 1)..(index + 1)] = sub_result.to_f.round(2)
      @calculation_array
    end

    # Sum the floats in the Array
    result = @calculation_array.select { |x| x.is_a? Float }.reduce(0, :+)
    format('%.2f', result)
  end

  def self.perform_calculation(index)
    number1 = @calculation_array[index - 1]
    operand = @calculation_array[index]
    number2 = @calculation_array[index + 1]
    number1.to_f.send operand, number2.to_f
  end

  private_class_method :perform_calculation
end
