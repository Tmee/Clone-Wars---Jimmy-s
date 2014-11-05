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
    "title" => title,
    "description" => description,
    "price" => price,
    "url_id" => url_id
  }
  end

end
