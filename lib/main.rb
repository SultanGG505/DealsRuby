# frozen_string_literal: true

require_relative 'views/main_window'
require_relative 'logger'

# создаёт окно, в котором и происходит вся работа в рамках поставленной индивидуальной задачи

LoggerHolder.instance.level = Logger::DEBUG
MainWindow.new.create.show

