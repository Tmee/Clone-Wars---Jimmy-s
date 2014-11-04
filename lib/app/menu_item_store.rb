require 'sequel'
require 'nokogiri'

class MenuItemStore
  attr_reader :database
  attr_reader :scrape_for_items
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
    db = if ENV["RACK_ENV"] == "production"
          Sequel.postgres('d8mr4qm3tinvhh',
            :user => 'gswvukupvdmxcu',
            :password => 'zJb4a_RudTaS4brpfbEorW87dx',
            :host => 'ec2-54-83-201-96.compute-1.amazonaws.com')
    else
      Sequel.sqlite 'db/menu_items.sqlite3'
    end
    db.create_table? :menu_items do
      primary_key :id
      String      :name,        :size => 255
      String      :price,       :size => 255
      String      :description, :text => true
    end
    db
  end

  def self.create(data)
    database.transaction do
      database['menu_items'] << data
    end
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
