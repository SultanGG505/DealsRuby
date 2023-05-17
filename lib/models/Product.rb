# frozen_string_literal: true

class Product
  attr_reader :id, :name, :price, :delivery
  def initialize(id, name, price, delivery)
    @id = id
    @name = name
    @price = price
    @delivery = delivery
  end
end