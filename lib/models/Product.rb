# frozen_string_literal: true

class Product
  attr_reader :id, :name, :price, :delivery

  def initialize(id, name, price, delivery = nil)
    validate_all_null(name, price)
    @id = id
    @name = name
    @price = price
    @delivery = delivery
  end

  private

  def validate_all_null(*args)
    args.each do |arg|
      if arg.nil?
        raise ArgumentError, "Argument '#{caller_locations(1, 1)[0].label}' cannot be null"
      end
    end
  end
end