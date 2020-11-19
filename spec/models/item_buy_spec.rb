require 'rails_helper'

RSpec.describe ItemBuy, type: :model do
  before do
    # 商品購入情報を生成
    @item_buy = FactoryBot.build(:item_buy)
  end

  describe '商品購入情報登録' do
    context '商品購入情報登録：正常系' do
      it '全項目が、入力ありの場合、登録できる' do
        # 登録確認
        expect(@item_buy).to be_valid
      end
      it '郵便番号が、ハイフンあり（123-4567）の場合、登録できる' do
        # 郵便番号にハイフンあり（123-4567）を設定
        @item_buy.postal_code = '123-4567'
        # 登録確認
        expect(@item_buy).to be_valid
      end
      it '都道府県が、選択肢（1:北海道）の場合、登録できる' do
        # 都道府県に選択肢（1:北海道）を設定
        @item_buy.prefecture_id = 1
        # 登録確認
        expect(@item_buy).to be_valid
      end
      it '都道府県が、選択肢（47:沖縄県）の場合、登録できる' do
        # 都道府県に選択肢（47:沖縄県）を設定
        @item_buy.prefecture_id = 47
        # 登録確認
        expect(@item_buy).to be_valid
      end
      it '建物名が、空の場合、登録できる' do
        # 建物名に空を設定
        @item_buy.building = ''
        # 登録確認
        expect(@item_buy).to be_valid
      end
      it '電話番号が、ハイフンなし（01234567891）の場合、登録できる' do
        # 電話番号にハイフンなし（01234567891）を設定
        @item_buy.phone_number = '01234567891'
        # 登録確認
        expect(@item_buy).to be_valid
      end
    end
  end
end
