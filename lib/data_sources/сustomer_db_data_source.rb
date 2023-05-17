require 'mysql2'
class CustomerDbDataSource
  def initialize(host, username, password, database)
    @client = Mysql2::Client.new(
      host: host,
      username: username,
      password: password,
      database: database
    )
  end

  def add(customer)
    query = "INSERT INTO Customer (customer_id, company_name, address, email) VALUES (#{customer.id}, '#{customer.company_name}', '#{customer.address}', '#{customer.email}')"
    @client.query(query)
  end

  def change(customer)
    query = "UPDATE Customer SET company_name='#{customer.company_name}', address='#{customer.address}', email='#{customer.email}' WHERE customer_id=#{customer.id}"
    @client.query(query)
  end

  def delete(id)
    query = "DELETE FROM Customer WHERE customer_id=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Customer WHERE customer_id=#{id}"
    result = @client.query(query).first
    if result
      Customer.new(result['customer_id'], result['company_name'], result['address'], result['email'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Customer ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)
    customers = []
    results.each do |result|
      customers << Customer.new(result['customer_id'], result['company_name'], result['address'], result['email'])
    end
    customers
  end


end