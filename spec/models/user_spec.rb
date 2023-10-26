require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できるとき' do
      it 'nickname/email/password/password_confirmation/last_name/first_name/last_name_kana/first_name_kana/birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません", "パスワードは半角英数字混合で入力してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角(漢字・ひらがな・カタカナ)で入力してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角(漢字・ひらがな・カタカナ)で入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください", "苗字（カナ）は全角(カタカナ)で入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください", "名前（カナ）は全角(カタカナ)で入力してください")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "生年月日を入力してください"
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは半角英数字混合で入力してください")
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは半角英数字混合で入力してください")
      end
      it 'passwordが全角のみだと登録できない' do
        @user.password = 'ＡＡＡＡＡＡ'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは半角英数字混合で入力してください")
      end
      it 'passwordが数字のみだと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは半角英数字混合で入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは半角英数字混合で入力してください")
      end
      it 'last_nameは、全角(漢字・ひらがな・カタカナ)でないと登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字は全角(漢字・ひらがな・カタカナ)で入力してください"
      end
      it 'first_nameは、全角(漢字・ひらがな・カタカナ)でないと登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は全角(漢字・ひらがな・カタカナ)で入力してください"
      end
      it 'last_name_kanaは、全角(カタカナ)でないと登録できない' do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字（カナ）は全角(カタカナ)で入力してください"
      end
      it 'first_name_kanaは、全角(カタカナ)でないと登録できない' do
        @user.first_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前（カナ）は全角(カタカナ)で入力してください"
      end

    end
  end
end
