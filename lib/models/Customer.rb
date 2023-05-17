# frozen_string_literal: true

class Customer
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attr_reader :id, :company_name, :address, :email

  def initialize(id, company_name, address = nil, email = nil)
    validate_all_null(company_name)
    validate_email(email)
    @id = id
    @company_name = company_name
    @address = address
    @email = email
  end

  private

  def validate_all_null(*args)
    args.each do |arg|
      if arg.nil?
        raise ArgumentError, "Argument '#{caller_locations(1, 1)[0].label}' cannot be null"
      end
    end
  end

  def validate_email(email)
    if email && !email.match?(EMAIL_REGEX)
      raise ArgumentError, "Invalid email format: #{email}"
    end
  end
end