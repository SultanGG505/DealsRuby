# frozen_string_literal: true

require './lib/state_holders/list_state_notifier'
require_relative '../ui/product_input_form'
require_relative 'product_input_form_controller_create'
require_relative 'product_input_form_controller_edit'
require_relative '../product_db_data_source'


require 'win32api'

class ProductListController

  attr_reader :state_notifier;

  def initialize(view)
    @view = view
    @state_notifier = ListStateNotifier.new
    @state_notifier.add_listener(@view)
    @product_rep = ProductDbDataSource.new

    @sort_columns = %w[product_id name price delivery]
    @sort_by = @sort_columns.first

    @delivery_filter_columns = [nil, true, false]
    @delivery_filter = @delivery_filter_columns.first

    end

  def on_view_created
    # begin
    #   @student_rep = StudentRepository.new(DBSourceAdapter.new)
    # rescue Mysql2::Error::ConnectionError
    #   on_db_conn_error
    # end
  end

  def show_view
    @view.create.show
  end

  def show_modal_add
    controller = ProductInputFormControllerCreate.new(self)
    view = ProductInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(current_page, per_page, selected_row)
    item = @state_notifier.get(selected_row)

    controller = ProductInputFormControllerEdit.new(self, item)
    view = ProductInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def delete_selected(current_page, per_page, selected_row)
    begin
      item = @state_notifier.get(selected_row)
      @product_rep.delete(item.id)
      @state_notifier.delete(item)
    rescue
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, "Cannot delete this Product(ID = " + item.id.to_s + ") because he is in assosiated with Deal", "Error", 0)
    end
  end

  def refresh_data(page, per_page)
    # begin
    #   @data_list = @student_rep.paginated_short_students(page, per_page, @data_list)
    #   @view.update_student_count(@student_rep.student_count)
    # rescue
    #   on_db_conn_error
    # end
    items = @product_rep.get_list(per_page, page, @sort_by, 'ASC', @delivery_filter)
    @state_notifier.set_all(items)
    @view.update_student_count(@product_rep.count)
  end

  def sort(page, per_page, sort_index)
    @sort_by = @sort_columns[sort_index]
    refresh_data(page, per_page)
  end

  def filter_delivery(page, per_page, filter_index)
    @delivery_filter = @delivery_filter_columns[filter_index]
    refresh_data(page, per_page)
  end


  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    exit(false)
  end
end
