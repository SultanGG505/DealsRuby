# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative 'tab_students'
require './lib/customer/ui/customer_view'
require './lib/customer/ui/customer_list_view'

class MainWindow
  include Glimmer

  def initialize
    @view_tab_students = TabStudentsView.new
  end

  def create
    window('Библиотека', 900, 200) {
      tab {
        tab_item('Авторы') {
          CustomerListView.new.create
        }

        tab_item('Вкладка 2') {
          CustomerView.new.build
        }

        tab_item('Студенты') {
          @view_tab_students.create
        }
      }
    }
  end
end
