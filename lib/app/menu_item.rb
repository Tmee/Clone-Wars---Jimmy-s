class MenuItem
  attr_reader :url_id, :name, :price, :description

  def initialize (data)
    url_id      = data[:url_id]
    name        = data[:name]
    price       = data[:price]
    description = data[:description]
  end

end
