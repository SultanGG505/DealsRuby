require './lib/logger'
class ListStateNotifier
  attr_reader :items

  def initialize
    @items = []
    @listeners = []
  end

  # устанавливает новое значение для items и уведомляет всех слушателей.
  def set_all(objects)
    @items = objects
    notify_listeners
  end

  # добавляет объект в массив items и уведомляет всех слушателей.
  def add(object)
    @items << object
    notify_listeners
  end

  #  возвращает объект из массива items по индексу.
  def get(number)
    @items[number]
  end

  # удаляет объект из массива items и уведомляет всех слушателей.
  def delete(object)
    @items.delete(object)
    notify_listeners
  end

  # заменяет объект в массиве items на новый объект и уведомляет всех слушателей.
  def replace(object, new_object)
    index = @items.index(object)
    @items[index] = new_object
    notify_listeners
  end

  # добавляет нового слушателя в массив listeners.
  def add_listener(listener)
    @listeners << listener
  end

  # удаляет слушателя из массива listeners.
  def delete_listener(listener)
    @listeners.delete(listener)
  end

  # уведомляет всех слушателей о изменении массива items.
  def notify_listeners
    @listeners.each do |listener|
      listener.update(@items)
    end
  end
end