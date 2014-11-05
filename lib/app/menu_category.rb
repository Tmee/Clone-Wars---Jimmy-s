class MenuCategory
  attr_reader :name, :title, :notes

  def initialize(data, database)
    @id         = data[:id]
    @title      = data[:name]
    @notes      = data[:notes]
    @database   = database
  end

  def menu_items
    @database.all_menu_items.select {|item| item.category_id == self.id}
  end
end
