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
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'nameが空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it 'descriptionが空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it 'category_idが空では保存できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'condition_idが空では保存できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end
      it 'delivery_charge_idが空では保存できない' do
        @item.delivery_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery charge can't be blank"
      end
      it 'prefecture_idが空では保存できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'period_idが空では保存できない' do
        @item.period_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "Period can't be blank"
      end
      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is out of setting range", "Price is invalid. Input half-width characters")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
      it 'priceの値が300未満では保存できない' do
        @item.price = '250'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
      it 'priceの値が10000000以上では保存できない' do
        @item.price = '20000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
      it 'priceの値が全角数値では保存できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range", "Price is invalid. Input half-width characters")
      end

    end
  end
end
