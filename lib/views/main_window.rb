# frozen_string_literal: true

require 'glimmer-dsl-libui'
require './lib/customer/ui/customer_list_view'
# require './lib/product/ui/product_view'
require './lib/product/ui/product_list_view'

# класс MainWindow, который из файлов реализованных сущностей создаёт
# их view и отрисовывает их на экране пользователя
# конкретно сейчас класс отрисовывает сущности Товар и Заказчик
class MainWindow
  include Glimmer

  def initialize
  end

  # метод, в котором происходит создание окон
  # для сущностей заказчик и товар
  def create
    window('Sales', 1400, 600) {
      tab {
        tab_item('Заказчики') {
          CustomerListView.new.create
        }

        tab_item('Товары') {
          ProductListView.new.create
        }

      }
    }
  end
end
