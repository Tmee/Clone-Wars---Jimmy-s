class MenuItem
  attr_reader :id,
              :name,
              :price,
              :description,
              :category_id

  def initialize (data)
    @id          = data[:id]
    @name        = data[:name]
    @price       = data[:price]
    @description = data[:description].gsub(/\n/, "")
    @category_id = data[:category_id]
  end


  def menu_items
    @database.all_menu_items.select {|item| item.category_id == self.id}
  end

end
