require 'mysql2'
require_relative 'db_client'
class ProductDbDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(product)
    query = "INSERT INTO Product (product_id, name, price, delivery) VALUES (#{product.id}, '#{product.name}', #{product.price}, '#{product.delivery}')"
    @client.query(query)
  end

  def change(product)
    query = "UPDATE Product SET name='#{product.name}', price=#{product.price}, delivery='#{product.delivery}' WHERE product_id=#{product.id}"
    @client.query(query)
  end

  def delete(id)
    query = "DELETE FROM Product WHERE product_id=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Product WHERE product_id=#{id}"
    result = @client.query(query).first
    if result
      Product.new(result['product_id'], result['name'], result['price'], result['delivery'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Product ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)
    products = []
    results.each do |result|
      products << Product.new(result['product_id'], result['name'], result['price'], result['delivery'])
    end
    products
  end
end
