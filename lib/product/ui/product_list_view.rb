# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative '../controllers/product_list_controller'
# require_relative '../controllers/product_controller'
require_relative 'product_input_form'


class ProductListView
  include Glimmer

  PAGE_SIZE = 20

  def initialize
    @controller = ProductListController.new(self)
    @current_page = 1
    @total_count = 0
  end

  def on_create
    @controller.on_view_created
    @controller.refresh_data(@current_page, PAGE_SIZE)
  end

  # Метод наблюдателя datalist
  # def on_datalist_changed(new_table)
  #   arr = new_table.to_2d_array
  #   arr.map do |row|
  #     row[3] = [row[3][:value], contact_color(row[3][:type])] unless row[3].nil?
  #   end
  #   @table.model_array = arr
  # end

  def update(products)
    @items = []

    i = 0
    products.each do |product|
      i += 1
      item_num = ((@current_page - 1) * PAGE_SIZE) + i
      @items << Struct.new(:№, :id, :имя_товара, :цена, :есть_быстрая_доставка).new(item_num, product.id, product.name, product.price, product.delivery)
    end

    @table.model_array = @items
    @page_label.text = "#{@current_page} / #{(@total_count / PAGE_SIZE.to_f).ceil}"
  end

  def update_student_count(new_cnt)
    @total_count = new_cnt
    @page_label.text = "#{@current_page} / #{(@total_count / PAGE_SIZE.to_f).ceil}"
  end

  def create
    root_container = horizontal_box {
      # Секция 1
      vertical_box {
        stretchy false

        # form {
        #   stretchy false
        #
        #   @filter_company_name = entry {
        #     label 'Имя товара'
        #   }
        #
        #   @filter_address = entry {
        #     label 'Цена'
        #   }
        #
        #   @filter_email = entry {
        #     label 'Есть быстрая доставка'
        #   }
        #
        # }

        vertical_box {
          stretchy false
          label {
            text 'Есть быстрая доставка'
          }

          combobox { |c|
            stretchy false
            items ['Неважно', 'Есть', 'Нет']
            selected 0
            on_selected do
              @controller.filter_delivery(@current_page, PAGE_SIZE, c.selected)
            end
          }
        }

        vertical_box {
          stretchy false
          label {
            text 'Сортировка'
          }

          combobox { |c|
            stretchy false
            items ['ID', 'Имя товара', 'Цена', 'Есть быстрая доставка']
            selected 0
            on_selected do
              @controller.sort(@current_page, PAGE_SIZE, c.selected)
            end
          }
        }

      }
      # Секция 2
      vertical_box {
        @table = refined_table(
          table_editable: false,
          filter: lambda do |row_hash, query|
            utf8_query = query.force_encoding("utf-8")
            row_hash['название товара'].include?(utf8_query)
          end,
          table_columns: {
            '№' => :text,
            'ID' => :text,
            'Имя товара' => :text,
            'Цена' => :text,
            'Есть быстрая доставка' => :text
          },
          per_page: PAGE_SIZE
        )

        @pages = horizontal_box {
          stretchy false

          button("<") {
            stretchy true

            on_clicked do
              @current_page = [@current_page - 1, 1].max
              @controller.refresh_data(@current_page, PAGE_SIZE)
            end

          }
          @page_label = label("...") { stretchy false }
          button(">") {
            stretchy true

            on_clicked do
              @current_page = [@current_page + 1, (@total_count / PAGE_SIZE.to_f).ceil].min
              @controller.refresh_data(@current_page, PAGE_SIZE)
            end
          }
        }
      }

      # Секция 3
      vertical_box {
        stretchy false

        button('Добавить') {
          stretchy false

          on_clicked {
            @controller.show_modal_add
          }
        }
        button('Изменить') {
          stretchy false

          on_clicked {
            @controller.show_modal_edit(@current_page, PAGE_SIZE, @table.selection) unless @table.selection.nil?
          }
        }
        button('Удалить') {
          stretchy false

          on_clicked {
            @controller.delete_selected(@current_page, PAGE_SIZE, @table.selection) unless @table.selection.nil?
            @controller.refresh_data(@current_page, PAGE_SIZE)
          }
        }
        button('Обновить') {
          stretchy false

          on_clicked {
            @controller.refresh_data(@current_page, PAGE_SIZE)
          }
        }
      }
    }
    on_create
    root_container
  end
end
