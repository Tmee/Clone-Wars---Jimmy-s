class MenuItem
  attr_reader :url_id, :name, :price, :description

  def initialize (data)
    url_id      = data[:url_id]
    name        = data[:name]
    price       = data[:price]
    description = data[:description]
  end

  def self.all
  end

  def save
  database.transaction do |db|
    db['menu_items'] ||= []
    db['menu_items'] << { url_id: url_id,
                          name: name,
                          price: price,
                          description: description
                        }
  end
end
