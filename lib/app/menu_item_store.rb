require 'yaml/store'

class MenuItemStore

  def self.all
    menu_items = []
    raw_menu_items.each_with_index do |data, i|
      menu_items << MenuItem.new(data)
    end
    menu_items
  end

  def self.raw_ideas
    database.transaction do |db|
      db['menu_items'] || []
    end
  end

  def self.database
    return @database if @database

    @database = YAML::Store.new('db/menu_items')
    @database.transaction do
      database['menu_items'] ||= []
    end
    @database
  end

  def self.create(data)
    database.transaction do
      database['menu_items'] << data
    end
  end
end
