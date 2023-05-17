# frozen_string_literal: true

class Customers
  attr_accessor :id, :company_name, :address, :email

  def initialize(id, company_name, address, email)
    @id = id
    @company_name = company_name
    @address = address
    @email = email
  end
end