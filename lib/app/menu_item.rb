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
  
end
