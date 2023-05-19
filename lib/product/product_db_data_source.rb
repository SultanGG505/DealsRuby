require 'mysql2'
require_relative '../data_sources/db_client'

# класс, который реализует связь между моделью Товар и базой данных
# посредством обработки sql-запросов
class ProductDbDataSource
  # функция, которая при инициализации класса создаёт экземпляр
  # DBClient, необходимый для непосредственного подключения к базе данных
  # с учётом логина и пароля, которым прописан в файле конфигурации БД
  def initialize
    @client = DBClient.instance
  end

  # функция, которая добавляет запись в сущность Товар
  def add(product)
    query = "INSERT INTO Product (name, price, delivery) VALUES ('#{product.name}', '#{product.price}', '#{product.delivery}')"
    @client.query(query)
    product_id = @client.last_id
    get(product_id)
  end

  # функция, которая изменяет запись в сущности товар
  def change(product)
    query = "UPDATE Product SET name='#{product.name}', price='#{product.price}', delivery='#{product.delivery}' WHERE product_id=#{product.id}"
    @client.query(query)
    get(product.id)
  end

  # фунция, которая удаляет запись в сущности товар
  def delete(id)
    query = "DELETE FROM Product WHERE product_id=#{id}"
    @client.query(query)
  end

  # фукнция, которая возвращает всю информацию об
  # объекте сущности с определённым ID
  def get(id)
    query = "SELECT * FROM Product WHERE product_id=#{id}"
    result = @client.query(query).first
    if result
      Product.new(result[:'product_id'], result[:'name'], result[:'price'], result[:'delivery'])
    else
      nil
    end
  end

  # функция, которая реализует фильтрацию по наличию или отсутствию
  # быстрой доставки в сущности Товар
  def get_list(page_size, page_num, sort_field, sort_direction, has_delivery = nil)
    offset = (page_num - 1) * page_size
    # ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}
    query = 'SELECT * FROM Product'

    if !has_delivery.nil?
      query += ' Where '
    end
    if has_delivery == true
      query += 'delivery IS NOT NULL '
    end
    if has_delivery == false
      query += 'delivery IS NULL '
    end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)
    products = []
    results.each do |result|
      products << Product.new(result[:'product_id'], result[:'name'], result[:'price'], result[:'delivery'])
    end
    products
  end

  # функция, которая возвращает количество записей
  # в сущности Товар
  def count
    query = 'SELECT COUNT(*) FROM Product'
    result = @client.query(query).first

    result[:'COUNT(*)']
  end

end