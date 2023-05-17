# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative 'tab_students'
require_relative 'customer_view'

class MainWindow
  include Glimmer

  def initialize
    @view_tab_students = TabStudents.new
  end

  def create
    window('Sales', 900, 200) {
      tab {
        # tab_item('Студенты') {
        #   @view_tab_students.create
        # }

        tab_item('Заказчики') {
          CustomerView.new.build
        }
        # tab_item('Вкладка 3') { }
      }
    }
  end
end
