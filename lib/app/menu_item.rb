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
    @description = data[:description]
    @category_id = data[:category_id]
  end

  def save
    MenuDatabase.create(to_h)
  end

  def to_h
  {
    "name" => name,
    "description" => description,
    "price" => price,
    "id" => id,
    "category_id" => category_id
  }
  end

end
