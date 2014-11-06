require 'sequel'
require 'nokogiri'
require './lib/app/menu_category'
require './lib/app/menu_item'
require './lib/app/scraper'

class MenuDatabase
  attr_reader :database, :menu_items, :menu_categories

  def initialize
    @database        = create_db
    @menu_items      = database.from(:menu_items)
    @menu_categories = database.from(:menu_categories)
  end

  def all_menu_items
    items = menu_items.select.to_a
    items.map {|item| MenuItem.new(item)}
  end

  def all_menu_categories
    categories = menu_categories.select.to_a
    categories.map {|category| MenuCategory.new(category, self)}
  end

  def delete(id)
    menu_items.where(:id => id).delete
  end

  def find_menu_item(id)
    item     = menu_items.where(:id => id).first
    MenuItem.new(item)
  end

  def find_item_category(id)
    category = menu_categories.where(:id => id).first
    MenuCategory.new(category, self)
  end

  def update_menu_item(params)
    menu_items.where(:id => params[:id])
              .update(:name => params[:name],
                      :price => params[:price],
                      :description => params[:description]
                      )
  end

  def update_menu_category(params)
    menu_categories.where(:id => params[:id])
                   .update(:title => params[:title],
                           :notes => params[:notes]
                          )
  end

  def create_db
    if ENV["RACK_ENV"] == "production"
       choose_postgres
    else
       choose_sqlite
    end
  end

  def choose_postgres
    Sequel.postgres('d8mr4qm3tinvhh',
    :user           => 'gswvukupvdmxcu',
    :password       => 'zJb4a_RudTaS4brpfbEorW87dx',
    :host           => 'ec2-54-83-201-96.compute-1.amazonaws.com')
  end

  def choose_sqlite
    Sequel.sqlite 'db/menu_items.sqlite3'
  end

  def create_menu_items_table(db)
    db.create_table? :menu_items do
     primary_key :id
     String      :name,        :size => 255
     String      :price,       :size => 255
     String      :description, :text => true
     Integer     :category_id, :size => 255
    end
  end

  def create_menu_category_table(db)
    db.create_table? :menu_categories do
      primary_key :id
      String      :name,    :size => 255
      String      :notes,   :text => true
      String      :sidebar, :size => 255
    end
  end

  def populate_menu_categories
    Scraper.scrape_for_menu_categories(menu_categories)
  end

  def populate_menu_items
    Scraper.scrape_for_menu_items(menu_items)
  end

end
