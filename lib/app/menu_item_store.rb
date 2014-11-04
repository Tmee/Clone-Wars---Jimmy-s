require 'sequel'
require 'nokogiri'

class MenuDatabase
  attr_reader :database

  def self.database
    # db = Sequel.sqlite 'db/menu_items.sqlite3'
    db = Sequel.postgres('d8mr4qm3tinvhh',
      :user => 'gswvukupvdmxcu',
      :password => 'zJb4a_RudTaS4brpfbEorW87dx',
      :host => 'ec2-54-83-201-96.compute-1.amazonaws.com')
    create_menu_items_table(db)
    create_menu_category_table(db)
    db
  end

  def create_menu_items_table(db)
    db.create_table? :menu_items do
      primary_key :id
      String      :name,        :size => 255
      Price       :price,       :size => 4
      String      :description, :size => 511
    end
  end

  def create_menu_category_table(db)
    

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
