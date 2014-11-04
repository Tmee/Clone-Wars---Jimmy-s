require 'sequel'
require 'nokogiri'

class MenuItemStore
  attr_reader :database
  attr_reader :scrape_for_items

  def self.database

  # DB = Sequel.postgres('mydatabase.db',:user=>'postgres',:password=>'my_password_here',:host=>'localhost',:port=>5432,:max_connections=>10)
  # DB.create_table :mytable do
  #   primary_key :id
  #   String :column_name
  # end
    db = Sequel.sqlite 'db/menu_items.sqlite3'
    db.create_table? :menu_items do
      primary_key :id
      String      :name,        :size => 255
      Price       :price,       :size => 4
      String      :description, :size => 511
    end
    db
  end

  def self.scrape_for_items
    page = Nokogiri::HTML(open("lib/app/views/menu.erb"))
    items = database.from(:menu_items)
    erb_items = page.css('li#dumb')

    erb_items.map do |item|
      items.insert(:name => item.css('div').first.css('span a').text,
                   :price => item.css('div').first.css('span.price').text,
                   :description => item.css('div.description').text.gsub('\n', '')
                   )
    end
  end

end
