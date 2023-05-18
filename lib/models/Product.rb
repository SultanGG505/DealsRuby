# frozen_string_literal: true

class Product
  attr_reader :id, :name, :price, :delivery

  def initialize(id, name, price, delivery = nil)
    validate_null('name', name)
    validate_null('price', price)
    @id = id
    @name = name
    @price = price
    @delivery = delivery
  end

  private

  def validate_null(name, value)
    if value.nil?
      raise ArgumentError, "Argument '#{name}' cannot be null"
    end
  end

end