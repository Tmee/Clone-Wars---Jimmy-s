class MenuCategory
  attr_reader :name, :title, :notes

  def initialize(data)
    name       = data[:name] #should be in format "category-item-[number]"
    title      = data[:title] #actualy title of category
    notes      = data[:notes]
    menu_items = []
  end

  def menu_items
  end

  def self.all
  end

end
