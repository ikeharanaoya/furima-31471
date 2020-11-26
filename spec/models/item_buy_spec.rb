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
    context '商品購入情報登録：異常系' do
      it '郵便番号が、空の場合、登録できない' do
        # 郵便番号に空を設定
        @item_buy.postal_code = ''
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号が、ハイフンあり半角英字（abc-wxyz）の場合、登録できない' do
        # 郵便番号にハイフンあり半角英字（abc-wxyz）を設定
        @item_buy.postal_code = 'abc-wxyz'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号が、ハイフンなし（1234567）の場合、登録できない' do
        # 郵便番号にハイフンなし（1234567）を設定
        @item_buy.postal_code = '1234567'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号が、前半2桁未満（12-4567）の場合、登録できない' do
        # 郵便番号に前半2桁未満（12-4567）を設定
        @item_buy.postal_code = '12-4567'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号が、後半4桁未満（123-567）の場合、登録できない' do
        # 郵便番号に後半4桁未満（123-567）を設定
        @item_buy.postal_code = '123-567'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '都道府県が、空の場合、登録できない' do
        # 都道府県に空を設定
        @item_buy.prefecture_id = nil
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("都道府県を選択してください")
      end
      it '都道府県が、未選択の場合、登録できない' do
        # 都道府県に未選択を設定
        @item_buy.prefecture_id = 0
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("都道府県を選択してください")
      end
      it '都道府県が、48以上の場合、登録できない' do
        # 都道府県に48以上を設定
        @item_buy.prefecture_id = 48
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が、空の場合、登録できない' do
        # 市区町村に空を設定
        @item_buy.city = ''
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が、空の場合、登録できない' do
        # 番地に空を設定
        @item_buy.addresses = ''
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が、空の場合、登録できない' do
        # 電話番号に空を設定
        @item_buy.phone_number = ''
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号が、半角英字の場合、登録できない' do
        # 電話番号に半角英字を設定
        @item_buy.phone_number = 'abcXYZ'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("電話番号は数値で入力してください")
      end
      it '電話番号が、全角英字の場合、登録できない' do
        # 電話番号に全角英字を設定
        @item_buy.phone_number = 'ａｂｃＸＹＺ'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("電話番号は数値で入力してください")
      end
      it '電話番号が、全角数字の場合、登録できない' do
        # 電話番号に空を設定
        @item_buy.phone_number = '１２３４５'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("電話番号は数値で入力してください")
      end
      it '電話番号が、ハイフンあり（123-456-910）の場合、登録できない' do
        # 電話番号に空を設定
        @item_buy.phone_number = '123-456-910'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("電話番号は数値で入力してください")
      end
      it '電話番号が、12桁の場合、登録できない' do
        # 電話番号に空を設定
        @item_buy.phone_number = '111122223333'
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      it 'トークンが、空の場合、登録できない' do
        # トークンに空を設定
        @item_buy.token = nil
        # 登録確認
        @item_buy.valid?
        # エラーメッセージ確認
        expect(@item_buy.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
    context '注文情報登録：アソシエーション確認' do
      it 'userとitemが、紐付いている場合、登録できる' do
        # 注文情報を生成
        @order = FactoryBot.build(:order)
        # 登録確認
        expect(@order).to be_valid
      end
      it 'userが、紐付いていない場合、登録できない' do
        # 注文情報を生成
        @order = FactoryBot.build(:order)
        # userに空を設定
        @order.user = nil
        # 登録確認
        @order.valid?
        # エラーメッセージ確認
        expect(@order.errors.full_messages).to include('Userを入力してください')
      end
      it 'itemが、紐付いていない場合、登録できない' do
        # 注文情報を生成
        @order = FactoryBot.build(:order)
        # itemに空を設定
        @order.item = nil
        # 登録確認
        @order.valid?
        # エラーメッセージ確認
        expect(@order.errors.full_messages).to include('Itemを入力してください')
      end
    end
    context '配達先情報登録：アソシエーション確認' do
      it 'orderが、紐付いている場合、登録できる' do
        # 注文情報を生成
        @shipping_address = FactoryBot.build(:shipping_address)
        # 登録確認
        expect(@shipping_address).to be_valid
      end
      it 'orderが、紐付いていない場合、登録できない' do
        # 注文情報を生成
        @shipping_address = FactoryBot.build(:shipping_address)
        # orderに空を設定
        @shipping_address.order = nil
        # 登録確認
        @shipping_address.valid?
        # エラーメッセージ確認
        expect(@shipping_address.errors.full_messages).to include('Orderを入力してください')
      end
    end
  end
end
