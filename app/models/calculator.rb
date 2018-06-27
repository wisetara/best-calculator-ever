# frozen_string_literal: true

class Calculator
  # If I were to spend more time, maybe I'd actually migrate in a model. If so,
  # I'd initialize the calculation params, give myself easy access to the array,
  # and separate the various blocks in the `self.calculate` method. For this
  # project keeping it simple (as simple as a full Rails app can be!) seemed
  # best, though.

  # UPDATE: Since I came back in here after Justin's feedback, you can see that I've
  # begun to do what I described above. CAVEAT: I wouldn't normally include ALL of
  # these comments, which ironically make it harder to read my code. But I wanted you
  # to see (for interview purposes) what I'm thinking is happening here. I am a fan
  # of calling a public method like calculate and then having it run through the
  # private methods it needs to call. I'd do more of that here, but I'm trying to
  # stick with the spirit of the "short" exercise.

  # Naming is hard.

  def self.calculate(calculation)
    # Split the run-together string into numbers and operands
    @calculation_array = calculation.split(/(\d+)/).drop(1)
    array_length = @calculation_array.length

    # This method converts all numbers to floats from the beginning. This means
    # our result will not always match IRB's result, but it will be more accurate.
    string_to_float_to_string

    # Calculate higher-precendence operations first and return the appropriate
    # float precision
    handle_high_operands(@calculation_array, array_length)

    # Any String digits in the Array need to be changed to floats
    @calculation_array.each_with_index do |element, index|
      next unless /\d+/.match? element
      @calculation_array[index] = element.to_f
    end

    # Handle subtraction
    @calculation_array.each_with_index do |element, index|
      next unless element.is_a? String
      next unless /\-/.match? element
      sub_result = perform_calculation(index)
      @calculation_array[(index - 1)..(index + 1)] = sub_result
      @calculation_array
    end

    # Sum the floats in the Array
    result = @calculation_array.select { |x| x.is_a? Float }.reduce(0, :+)
    format('%.2f', result)
  end

  def self.string_to_float_to_string
    @calculation_array.each_with_index do |element, index|
      next unless element.is_a? String
      next unless /\d+/.match? element
      @calculation_array[index] = element.to_f.to_s
    end
  end

  # In a refactor, I'd tighten up this method, but I figure my first stab at it is
  # a good way for you to see how I initially think through my plan o' attack.
  def self.handle_high_operands(calculation_array, array_length)
    @calculation_array = calculation_array

    @calculation_array.each_with_index do |element, index|
      next unless /\*|\/|\%/.match? element
      sub_result = perform_calculation(index)
      @calculation_array[(index - 1)..(index + 1)] = sub_result.to_f.round(2).to_s
      if @calculation_array.length != array_length
        handle_high_operands(@calculation_array, @calculation_array.length)
      end
    end
    @calculation_array
  end

  def self.perform_calculation(index)
    number1 = @calculation_array[index - 1]
    operand = @calculation_array[index]
    number2 = @calculation_array[index + 1]
    number1.to_f.send operand, number2.to_f
  end

  private_class_method :string_to_float_to_string, :handle_high_operands, :perform_calculation
end
