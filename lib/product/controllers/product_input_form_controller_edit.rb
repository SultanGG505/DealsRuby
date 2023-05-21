# frozen_string_literal: true

require 'win32api'

# контроллер, которые отвечает за редактирование
# данных в рамках данной сущности

class ProductInputFormControllerEdit
  def initialize(parent_controller, item)
    @parent_controller = parent_controller
    @item = item
    @product_rep = ProductDbDataSource.new
  end

  def set_view(view)
    @view = view
  end

  def on_view_created
    # begin
    #   @student_rep = StudentRepository.new(DBSourceAdapter.new)
    # rescue Mysql2::Error::ConnectionError
    #   on_db_conn_error
    # end

    # @item = @customer_rep.get(@item_id)
    @view.make_readonly(:delivery)
    populate_fields(@item)
  end

  def populate_fields(item)
    @view.set_value(:name, item.name)
    @view.set_value(:price, item.price.to_s)
    @view.set_value(:delivery, item.delivery)
  end

  def process_fields(fields)
    begin
      # new_item = Customer.new(@item_id, *fields.values)
      # @customer_rep.change(new_item)
      item = Product.new(@item.id, *fields.values)
      item = @product_rep.change(item)
      @parent_controller.state_notifier.replace(@item, item)
      @view.close
    rescue ArgumentError => e
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, e.message, 'Error', 0)
    end
  end

  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    @view.close
  end
end
