require 'glimmer-dsl-libui'
require './lib/models/Customer'

class CustomerView
  include Glimmer

  PAGE_SIZE = 20

  def initialize
    # @controller = TabStudentsController.new(self)
    @items = []
    @current_page = 1
    @total_count = 0

    @items = [
      Customer.new(1, 'СулМаз', 'ул.Кубанская', 'sultan@gmail.com'),
      Customer.new(2, 'МазСул', 'ул.Докторов', 'almaz@gmail.com'),
      Customer.new(3, 'ГазПром', 'ул.Рыбаков', 'almaz@gmail.com'),
    ]

  end

  def on_create
    update(@items)
    # @controller.on_view_created
    # @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
  end

  def update(customers)
    items = []

    customers.each do |customer|
      items << Struct.new(:номер, :название_фирмы, :адрес, :почта).new(customer.id, customer.company_name, customer.address, customer.email)
    end

    @table.model_array = items
  end

  def total_pages
    (@items.size.to_f / PAGE_SIZE).ceil
  end

  def selected_index
    (@current_page - 1) * PAGE_SIZE
  end

  def displayed_items
    @items[selected_index, PAGE_SIZE] || []
  end

  def build
    root_container = horizontal_box {
      # Секция 1
      vertical_box {
        stretchy false

        form {
          stretchy false

          @company_name = entry {
            label 'название_фирмы'
          }

          @address = entry {
            label 'адрес'
          }
        }
      }

      # Секция 2
      vertical_box {
        @table = refined_table(
          table_editable: false,
          filter: lambda do |row_hash, query|
            utf8_query = query.force_encoding("utf-8")
            row_hash['название фирмы'].include?(utf8_query)
          end,
          table_columns: {
            'номер' => :text,
            'название фирмы' => :text,
            'адрес' => :text,
            'почта' => :text
          }

        )

        @pages = horizontal_box {
          stretchy false

          button("<") {
            stretchy true

            on_clicked do
              @current_page = [@current_page - 1, 1].max
              # @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
            end

          }
          @page_label = label("...") { stretchy false }
          button(">") {
            stretchy true

            on_clicked do
              @current_page = [@current_page + 1, (@total_count / STUDENTS_PER_PAGE.to_f).ceil].min
              # @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
            end
          }
        }
      }

      # Секция 3
      vertical_box {
        stretchy false

        button('Добавить') { stretchy false }
        button('Изменить') { stretchy false }
        button('Удалить') { stretchy false }
        button('Обновить') {
          stretchy false

          on_clicked {
            # @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
          }
        }
      }
    }
    on_create
    root_container
  end

end
