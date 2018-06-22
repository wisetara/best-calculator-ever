# frozen_string_literal: true

class CalculatorController < ApplicationController
  def index
    render :index
  end

  def compute
    @result = Calculator.send(:calculate, params[:calculation])
    render :index
  end
end
