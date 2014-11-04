require 'sequel'
require 'nokogiri'

class MenuDatabase
  attr_reader :database

  def self.database
    db = create_db
    create_menu_items_table(db)
    create_menu_category_table(db)
    db
  end

  def self.create_db
    if ENV["RACK_ENV"] == "production"
       Sequel.postgres('d8mr4qm3tinvhh',
       :user => 'gswvukupvdmxcu',
       :password => 'zJb4a_RudTaS4brpfbEorW87dx',
       :host => 'ec2-54-83-201-96.compute-1.amazonaws.com')
    else
       db = Sequel.sqlite 'db/menu_items.sqlite3'
    end
  end

  def self.create_menu_items_table(db)
    db.create_table? :menu_items do
     primary_key :id
     String      :name,        :size => 255
     String      :price,       :size => 255
     String      :description, :text => true
    end
  end

  def self.create_menu_category_table(db)
    db.create_table? :menu_categories do
      primary_key :id
      String      :name,   :size => 255
      String      :title,  :size => 255
      String      :notes,  :text => true
    end
  end

  def self.scrape_for_menu_items
    items = database.from(:menu_items)
    erb_items = menu_page.css('li#dumb')

    erb_items.map do |item|
      items.insert(:name => item.css('div').first.css('span a').text,
                   :price => item.css('div').first.css('span.price').text,
                   :description => item.css('div.description').text.gsub('\n', '')
                   )
    end
  end

  def self.scrape_for_menu_categories
    categories= database.from(:menu_categories)
    erb_items = menu_page.css('li#dumb')

    erb_items.map do |item|
      items.insert(:name => item.css('div').first.css('span a').text,
                   :price => item.css('div').first.css('span.price').text,
                   :description => item.css('div.description').text.gsub('\n', '')
                   )
    end
  end

  def self.menu_page
    Nokogiri::HTML(open("lib/app/views/menu.erb"))
  end
end
