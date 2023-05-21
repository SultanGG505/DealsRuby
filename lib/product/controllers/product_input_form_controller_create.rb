# frozen_string_literal: true

require 'win32api'

# контроллер, которые отвечает за создание
# данных в рамках данной сущности

class ProductInputFormControllerCreate
  def initialize(parent_controller)
    @parent_controller = parent_controller
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
    @view.make_readonly(:delivery)
  end

  def process_fields(fields)
    begin
      puts fields
      item = Product.new(-1, *fields.values)
      puts item
      item = @product_rep.add(item)
      @parent_controller.state_notifier.add(item)
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
