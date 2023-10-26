require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品投稿' do
    context '商品が投稿できる場合' do
      it 'name/description/category_id/condition_id/delivery_charge_id/prefecture_id/period_id/price/image
      が存在していれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が投稿できない場合' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "商品画像を入力してください"
      end
      it 'nameが空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it 'descriptionが空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end
      it 'category_idが空では保存できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを入力してください"
      end
      it 'condition_idが空では保存できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を入力してください"
      end
      it 'delivery_charge_idが空では保存できない' do
        @item.delivery_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を入力してください"
      end
      it 'prefecture_idが空では保存できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を入力してください"
      end
      it 'period_idが空では保存できない' do
        @item.period_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を入力してください"
      end
      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください", "販売価格は¥300~¥9,999,999の範囲に設定してください", "販売価格は半角数字で入力してください")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "ユーザーを入力してください"
      end
      it 'priceの値が300未満では保存できない' do
        @item.price = '250'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は¥300~¥9,999,999の範囲に設定してください"
      end
      it 'priceの値が10000000以上では保存できない' do
        @item.price = '20000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は¥300~¥9,999,999の範囲に設定してください"
      end
      it 'priceの値が全角数値では保存できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は¥300~¥9,999,999の範囲に設定してください", "販売価格は半角数字で入力してください")
      end

    end
  end
end
