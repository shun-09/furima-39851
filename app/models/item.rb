class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :period

  with_options presence: true do
    validates :name, :description, :price, :image
    validates :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :period_id,
              numericality: { other_than: 1, message: "can't be blank" }
  end

  validates :price, numericality: {
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "is out of setting range"
  }
  validates :price, numericality: { only_integer: true, message: "is invalid. Input half-width characters" }
end
