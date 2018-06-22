# frozen_string_literal: true

require 'test_helper'

class CalculatorTest < ActiveSupport::TestCase
  def test_should_create_calculation
    results = []
    assert_equal(0, results.count)
    assert_difference('results.count') do
      results << Calculator.calculate('2+1')
    end
    assert_equal(1, results.count)
  end

  def test_should_return_accurate_calculation
    result = Calculator.calculate('20+3')
    assert_equal('23.00', result)
  end

  def test_should_handle_subtraction
    result = Calculator.calculate('20+3-4')
    assert_equal('19.00', result)
  end

  def test_should_return_accurate_order_precedence
    result1 = Calculator.calculate('5*3+1+6/2+9*100')
    result2 = Calculator.calculate('5*3+1+6/85+9*100')
    assert_equal('919.00', result1)
    assert_equal('916.07', result2)
  end
end
