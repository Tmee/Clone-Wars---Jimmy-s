require 'sequel'
require 'nokogiri'
require './lib/app/menu_category'
require './lib/app/menu_item'

class MenuDatabase
  attr_reader :database

  def self.database
    db = create_db
    create_menu_items_table(db)
    create_menu_category_table(db)
    db
  end

  def self.delete(id)
    database.from(:menu_items).where(:id => id).delete
  end

  def self.find_menu_item(id)
    item = database.from(:menu_items).where(:id => id).to_a
    item.map {|item| MenuItem.new(item)}
  end

  def self.find_item_category(id)
    category = database.from(:menu_categories).where(:id => id).to_a
    category.map {|category| MenuCategory.new(category, self)}
  end

  def self.update_menu_item(params)

    database.from(:menu_items).where(:id => params[:id])
                              .update(:name => params[:name],
                                      :price => params[:price],
                                      :description => params[:description]
                                      )

  end


  def self.update_menu_category(params)
    database.from(:menu_categories).where(:id => params[:id])
                                   .update(:title => params[:title],
                                           :notes => params[:notes]
                                           )
  end

  def self.disconnect
    database.disconnect
  end

  def self.create(data)
    database.transaction do
      database['menu_items'] << data
    end
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
     Integer     :category_id, :size => 255
    end
  end

  def self.create_menu_category_table(db)
    db.create_table? :menu_categories do
      primary_key :id
      String      :name,    :size => 255
      String      :notes,   :text => true
      String      :sidebar, :size => 255
    end
  end

  def self.scrape_for_menu_categories
    categories_table       = database.from(:menu_categories)
    categories             = menu_page.css('h2')
    descriptions           = menu_page.css('p').map(&:text)
    organized_descriptions = Hash[*categories.zip(descriptions).flatten]

    categories.map do |category|
      categories_table.insert(:name  => category.text,
                              :notes => organized_descriptions[category],
                              :sidebar => category["name"]
                              )
    end
  end

  def self.scrape_for_menu_items
    items     = database.from(:menu_items)
    erb_items = menu_page.css('li#dumb')
    erb_items.map do |item|
      items.insert(:name => item.css('div').first.css('span a').text,
                   :price => item.css('div').first.css('span.price').text,
                   :description => item.css('div.description').text.gsub('\n', ''),
                   :category_id => item["category-id"]
                   )
    end
  end

  def self.menu_page
    Nokogiri::HTML(open("db/backup_db/backup_menu_view.erb"))
  end

  def self.all_menu_items
    items = database.from(:menu_items).select.to_a
    items.map {|item| MenuItem.new(item)}
  end

  def self.all_menu_categories
    categories = database.from(:menu_categories).select.to_a
    categories.map {|category| MenuCategory.new(category, self)}
  end

end
