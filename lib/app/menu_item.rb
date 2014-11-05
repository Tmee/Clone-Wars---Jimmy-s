class MenuItem
  attr_reader :url_id, :name, :price, :description

  def initialize (data)
    url_id      = data[:url_id]
    name        = data[:name]
    price       = data[:price]
    description = data[:description]
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
