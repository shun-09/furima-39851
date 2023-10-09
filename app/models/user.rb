class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  VALID_FORMAT_JAPANESE = /\A[ぁ-んァ-ヶー一-龠々]+\z/
  VALID_FORMAT_KANA = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: VALID_FORMAT_JAPANESE }
    validates :first_name, format: { with: VALID_FORMAT_JAPANESE }
    validates :kana_last_name, format: { with: VALID_FORMAT_KANA }
    validates :kana_first_name, format: { with: VALID_FORMAT_KANA }
    validates :birth_date
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  
end
