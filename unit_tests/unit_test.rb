require 'minitest/autorun'
require './lib/models/Customer'
require './lib/models/Deal'
require './lib/models/Product'
class CustomerTest < Minitest::Test
  def test_customer_with_valid_data
    customer = Customer.new(1, 'ABC Company', 'Address', 'email@example.com')
    assert_equal 1, customer.id
    assert_equal 'ABC Company', customer.company_name
    assert_equal 'Address', customer.address
    assert_equal 'email@example.com', customer.email
  end

  def test_customer_with_null_id
    error = assert_raises(ArgumentError) do
      Customer.new(nil, 'ABC Company', 'Address', 'email@example.com')
    end
    assert_equal "Argument 'id' cannot be null", error.message
  end

  def test_customer_with_null_company_name
    error = assert_raises(ArgumentError) do
      Customer.new(1, nil, 'Address', 'email@example.com')
    end
    assert_equal "Argument 'company_name' cannot be null", error.message
  end

  def test_customer_with_invalid_email_format
    error = assert_raises(ArgumentError) do
      Customer.new(1, 'ABC Company', 'Address', 'invalid_email')
    end
    assert_equal "Invalid email format: invalid_email", error.message
  end
end

class DealTest < Minitest::Test
  def test_deal_with_valid_data
    deal = Deal.new(1, '2023-05-21', 5, 1, 1)
    assert_equal 1, deal.id
    assert_equal '2023-05-21', deal.purchase_date
    assert_equal 5, deal.quantity
    assert_equal 1, deal.customer_id
    assert_equal 1, deal.product_id
  end

  def test_deal_with_null_purchase_date
    error = assert_raises(ArgumentError) do
      Deal.new(1, nil, 5, 1, 1)
    end
    assert_equal "Argument 'purchase_date' cannot be null", error.message
  end

  def test_deal_with_null_quantity
    error = assert_raises(ArgumentError) do
      Deal.new(1, '2023-05-21', nil, 1, 1)
    end
    assert_equal "Argument 'quantity' cannot be null", error.message
  end

  def test_deal_with_null_customer_id
    error = assert_raises(ArgumentError) do
      Deal.new(1, '2023-05-21', 5, nil, 1)
    end
    assert_equal "Argument 'customer_id' cannot be null", error.message
  end

  def test_deal_with_null_product_id
    error = assert_raises(ArgumentError) do
      Deal.new(1, '2023-05-21', 5, 1, nil)
    end
    assert_equal "Argument 'product_id' cannot be null", error.message
  end
end

class ProductTest < Minitest::Test
  def test_product_with_valid_data
    product = Product.new(1, 'Product 1', 10, 'Delivery')
    assert_equal 1, product.id
    assert_equal 'Product 1', product.name
    assert_equal 10, product.price
    assert_equal 'Delivery', product.delivery
  end

  def test_product_with_null_name
    error = assert_raises(ArgumentError) do
      Product.new(1, nil, 10, 'Delivery')
    end
    assert_equal "Argument 'name' cannot be null", error.message
  end

  def test_product_with_null_price
    error = assert_raises(ArgumentError) do
      Product.new(1, 'Product 1', nil, 'Delivery')
    end
    assert_equal "Argument 'price' cannot be null", error.message
  end

  def test_product_with_zero_price
    error = assert_raises(ArgumentError) do
      Product.new(1, 'Product 1', 0, 'Delivery')
    end
    assert_equal "Argument 'price' must be greater than zero", error.message
  end
end


