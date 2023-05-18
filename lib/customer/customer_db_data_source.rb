require 'mysql2'
require_relative '../data_sources/db_client'

class CustomerDbDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(customer)
    query = "INSERT INTO Customer (company_name, address, email) VALUES ('#{customer.company_name}', '#{customer.address}', '#{customer.email}')"
    @client.query(query)
    customer_id = @client.last_id
    get(customer_id)
  end

  def change(customer)
    query = "UPDATE Customer SET company_name='#{customer.company_name}', address='#{customer.address}', email='#{customer.email}' WHERE customer_id=#{customer.id}"
    @client.query(query)
    get(customer.id)
  end

  def delete(id)
    query = "DELETE FROM Customer WHERE customer_id=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Customer WHERE customer_id=#{id}"
    result = @client.query(query).first
    if result
      Customer.new(result[:'customer_id'], result[:'company_name'], result[:'address'], result[:'email'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction, has_address = nil, has_email = nil)
    offset = (page_num - 1) * page_size
    # ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}
    query = "SELECT * FROM Customer"

    if !has_address.nil? or !has_email.nil?
      query += " Where "
    end
    if has_address == true
      query += "address IS NOT NULL "
    end
    if has_address == false
      query += "address IS NULL "
    end
    if !has_address.nil? and !has_email.nil?
      query += "and "
    end
    if has_email == true
      query += "email IS NOT NULL "
    end
    if has_email == false
      query += "email IS NULL "
    end

    # if has_address == true and has_email == true
    #   query += "WHERE address IS NOT NULL and email IS NOT NULL"
    # end
    # if has_address == true and has_email == false
    #   query += "WHERE address IS NOT NULL and email IS NULL"
    # end
    # if has_address == false and has_email == true
    #   query += "WHERE address IS NULL and email IS NOT NULL"
    # end
    # if has_address == false and has_email == false
    #   query += "WHERE address IS NULL and email IS NULL"
    # end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)
    customers = []
    results.each do |result|
      customers << Customer.new(result[:'customer_id'], result[:'company_name'], result[:'address'], result[:'email'])
    end
    customers
  end

  def count
    query = "SELECT COUNT(*) FROM Customer"
    result = @client.query(query).first

    result[:'COUNT(*)']
  end

end