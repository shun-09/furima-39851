require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user_id: user.id)
      @order_address = FactoryBot.build(:order_address, user_id: item.user_id, item_id: item.id)
      sleep(0.001)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題ない場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は「3桁ハイフン4桁」の半角文字列で入力してください (例 123-4567)")
      end
      it 'prefecture_idが空だと保存できないこと' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "都道府県を入力してください"
      end
      it 'municipalityが空だと保存できないこと' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'blockが空だと保存できないこと' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください", "電話番号が短いです", "電話番号は半角数字で入力してください")
      end
      it 'tokenが空だと保存できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は「3桁ハイフン4桁」の半角文字列で入力してください (例 123-4567)")
      end
      it '電話番号が9桁以下では購入できない' do
        @order_address.phone_number = 123
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が短いです")
      end
      it '電話番号が12桁以上では購入できない' do
        @order_address.phone_number = 123456789123456
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が短いです")
      end
      it 'phone_numberが半角数値でないと保存できないこと' do
        @order_address.phone_number = '１２３４５６７８９１２'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が短いです", "電話番号は半角数字で入力してください")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("商品を入力してください")
      end
    end
  end
end
