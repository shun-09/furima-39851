class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶー一-龠々]+\z/} do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/} do
    validates :kana_last_name
    validates :kana_first_name
  end


end
