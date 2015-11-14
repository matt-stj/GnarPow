class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def total
    contents.values.sum
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def update_quantity(params)
    self.contents.select { |item, _quantity| item == params[:id] }
                    .map { |item, _quantity|
                            self.contents[item] = params[:quantity].to_i }
  end

  def remove_items(params)
    self.contents.delete_if { |item_id, _quantity| item_id == params[:id] }
  end

  def items
    contents.map do |item_id, count|
      item = Item.find(item_id)
      CartItem.new(item, count)
    end
  end
end

class CartItem < SimpleDelegator
  attr_accessor :count

  def initialize(item, count)
    super(item)

    @count = count
  end

end
