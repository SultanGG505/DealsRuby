# frozen_string_literal: true

require 'glimmer-dsl-libui'
require './lib/customer/ui/customer_view'
require './lib/customer/ui/customer_list_view'
# require './lib/product/ui/product_view'
require './lib/product/ui/product_list_view'
class MainWindow
  include Glimmer

  def initialize
    # @view_tab_students = TabStudentsView.new
  end

  def create
    window('Sales', 1400, 600) {
      tab {
        tab_item('Заказчики') {
          CustomerListView.new.create
        }

        tab_item('Товары') {
          ProductListView.new.create
        }

        # tab_item('Студенты') {
        #   @view_tab_students.create
        # }
      }
    }
  end
end
