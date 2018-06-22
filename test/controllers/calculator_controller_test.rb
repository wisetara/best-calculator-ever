# frozen_string_literal: true

require 'test_helper'

class CalculatorControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get calculator_index_url
    assert_response :success
  end

  test 'can load with params' do
    get index_url, params: { calculation: '20 + 4' }
    assert_includes(@response.body, 'Result = 24.00')
  end
end
