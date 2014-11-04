require 'sequel'
class MenuItemStore
  attr_reader :database
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
    @database = Sequel.sqlite 'db/menu_items.sqlite3'
    database.create_table? :menu_items do
      primary_key :id
      String      :url_id,      :size => 255
      String      :name,        :size => 255
      Price       :price,       :size => 4
      String      :description, :size => 511
      String      :category_id, :size => 31
    end
    @database
  end

  def self.create(data)
    database.transaction do
      database['menu_items'] << data
    end
  end
end

  def self.scrape_for_items
    page = Nokogiri::HTML(open("lib/app/views/menu.erb"))
    items = database
    erb_items = page.css('li#dumb')
    erb_items.map do |item|
    items.insert( :name => item.css('div').first.css('span a').text,
                  :price => item.css('div').first.css('span.price').text,
                  :description => item.first.css('div.description').text
                 )
  end

items.insert(:name => "Greek Nachos", :price => 8, :description => "House made pita chips, hummus, gyro meat drizzled with red pepper aioli and raita sauce.", :category_id => "category-item-3")
items.insert(:name => "Hot Wings", :price => 0, :description => "Choose one of our &#8220;Award Winning&#8221; sauces: BBQ, Original, Chipotle, Sriracha, Spicy BBQ or Melagueta.", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
items.insert(:name => "", :price => 0, :description => "", :category_id => "category-item-3")
