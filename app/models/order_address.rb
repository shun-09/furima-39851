class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality,
                :block, :building_name, :phone_number, :order_id

  with_options presence: true do
    validates :user_id, :item_id, :municipality, :block, :phone_number
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :postal_code, format: {
      with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"
    }
  end
  validates :phone_number, numericality: { with: /\A\d{10,11}\z/, message: ' is too short' }
  validates :phone_number, numericality: { only_integer: true, message: ' is invalid. Input only number' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, block: block, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
