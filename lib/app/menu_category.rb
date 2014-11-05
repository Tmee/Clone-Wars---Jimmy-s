class MenuCategory
  attr_reader :id, :title, :notes, :name, :sidebar

  def initialize(data, database)
    @sidebar    = data[:sidebar]
    @id         = data[:id]
    @title      = data[:name]
    @notes      = data[:notes]
    @database   = database
  end

  def menu_items
    @database.all_menu_items.select {|item| item.category_id == self.id}
  end
end
