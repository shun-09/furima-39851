class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality,
                :block, :building_name, :phone_number, :order_id, :token

  with_options presence: true do
    validates :user_id, :item_id, :municipality, :block, :phone_number, :token
    validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :postal_code, format: {
      with: /\A\d{3}-\d{4}\z/, message: "は「3桁ハイフン4桁」の半角文字列で入力してください (例 123-4567)"
    }
  end
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'が短いです' }
  validates :phone_number, format: { with: /\A\d+\z/, message: 'は半角数字で入力してください' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, block: block, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
