# frozen_string_literal: true

require './lib/state_holders/list_state_notifier'
require_relative '../ui/customer_input_form'
require_relative 'customer_input_form_controller_create'
require_relative 'customer_input_form_controller_edit'
require 'win32api'

class CustomerListController
  def initialize(view)
    @view = view
    @state_notifier = ListStateNotifier.new
    @state_notifier.add_listener(@view)
    @customer_rep = CustomerDbDataSource.new
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
    controller = CustomerInputFormControllerCreate.new(self)
    view = CustomerInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(current_page, per_page, selected_row)
    item_num = (current_page - 1) * per_page + selected_row
    item_id = @state_notifier.get(item_num).id

    controller = CustomerInputFormControllerCreate.new(self, item_id)
    view = CustomerInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def delete_selected(current_page, per_page, selected_row)
    # begin
      item_num = (current_page - 1) * per_page + selected_row
      item = @state_notifier.get(item_num)
      @state_notifier.delete(item)
      @customer_rep.delete(item.id)
    # rescue
    #   on_db_conn_error
    # end
  end

  def refresh_data(page, per_page)
    # begin
    #   @data_list = @student_rep.paginated_short_students(page, per_page, @data_list)
    #   @view.update_student_count(@student_rep.student_count)
    # rescue
    #   on_db_conn_error
    # end
    items = @customer_rep.get_list(per_page, page, 'company_name', 'ASC' )
    @state_notifier.set_all(items)
    @view.update_student_count(@customer_rep.count)
  end



  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    # TODO: Возможность переключения на JSON помимо exit
    exit(false)
  end
end
