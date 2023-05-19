# frozen_string_literal: true

# модель для сущности Заказчик
# данная модель реализует валидацию данных
class Customer
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attr_reader :id, :company_name, :address, :email

  def initialize(id, company_name, address = nil, email = nil)
    validate_null('id', id)
    validate_null('company_name', company_name)
    # validate_null('address', address)
    # validate_null('email', email)
    validate_email(email)
    @id = id
    @company_name = company_name
    @address = address
    @email = email
  end

  private

  def validate_null(name,value)
    if value.nil?
      raise ArgumentError, "Argument '#{name}' cannot be null"
    end
  end

  def validate_email(email)
    if email && !email.match?(EMAIL_REGEX)
      raise ArgumentError, "Invalid email format: #{email}"
    end
  end
end