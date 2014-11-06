class Scraper

  def self.menu_page
    Nokogiri::HTML(open("db/backup_db/backup_menu_view.erb"))
  end

  def self.scrape_for_menu_categories(menu_categories)
    categories_table       = menu_categories
    categories             = menu_page.css('h2')
    descriptions           = menu_page.css('p').map(&:text)
    organized_descriptions = Hash[*categories.zip(descriptions).flatten]

    categories.map do |category|
      categories_table.insert(:name    => category.text,
                              :notes   => organized_descriptions[category],
                              :sidebar => category["name"]
                              )
    end
  end

  def self.scrape_for_menu_items(menu_items)
    items     = menu_items
    erb_items = menu_page.css('li#dumb')
    erb_items.map do |item|
      items.insert(:name        => item.css('div').first.css('span a').text,
                   :price       => item.css('div').first.css('span.price').text,
                   :description => item.css('div.description').text.gsub('\n', ''),
                   :category_id => item["category-id"]
                   )
    end
  end

end
