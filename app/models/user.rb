class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  VALID_FORMAT_JAPANESE = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_FORMAT_KANA = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_FORMAT_JAPANESE, message: 'is invalid. Input full-width characters' }
    validates :first_name, format: { with: VALID_FORMAT_JAPANESE, message: 'is invalid. Input full-width characters' }
    validates :last_name_kana, format: { with: VALID_FORMAT_KANA, message: 'is invalid. Input full-width characters' }
    validates :first_name_kana, format: { with: VALID_FORMAT_KANA, message: 'is invalid. Input full-width characters' }
    validates :birth_date
  end

  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is invalid. Include both letters and numbers'
  }
end
