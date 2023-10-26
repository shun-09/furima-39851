class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy

  VALID_FORMAT_JAPANESE = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_FORMAT_KANA = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_FORMAT_JAPANESE, message: 'は全角(漢字・ひらがな・カタカナ)で入力してください' }
    validates :first_name, format: { with: VALID_FORMAT_JAPANESE, message: 'は全角(漢字・ひらがな・カタカナ)で入力してください' }
    validates :last_name_kana, format: { with: VALID_FORMAT_KANA, message: 'は全角(カタカナ)で入力してください' }
    validates :first_name_kana, format: { with: VALID_FORMAT_KANA, message: 'は全角(カタカナ)で入力してください' }
    validates :birth_date
  end

  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字混合で入力してください'
  }
end
