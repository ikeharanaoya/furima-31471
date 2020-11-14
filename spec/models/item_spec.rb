require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    # 商品を生成
    @item = FactoryBot.build(:item)
  end

  describe '商品新規登録' do
    context '新規登録：正常系' do
      it '全項目が、入力ありの場合、登録できる' do
        # 登録確認
        expect(@item).to be_valid
      end
      it 'カテゴリーが、選択肢（1:レディース）の場合、登録できる' do
        # カテゴリーに選択肢（1:レディース）を設定
        @item.category_id = 1
        # 登録確認
        expect(@item).to be_valid
      end
      it 'カテゴリーが、選択肢（10:その他）の場合、登録できる' do
        # カテゴリーに選択肢（10:その他）を設定
        @item.category_id = 10
        # 登録確認
        expect(@item).to be_valid
      end
      it '商品の状態が、選択肢（1:新品、未使用）の場合、登録できる' do
        # 商品の状態に選択肢（1:新品、未使用）を設定
        @item.sales_status_id = 1
        # 登録確認
        expect(@item).to be_valid
      end
      it '商品の状態が、選択肢（6:全体的に状態が悪い）の場合、登録できる' do
        # 商品の状態に選択肢（6:全体的に状態が悪い）を設定
        @item.sales_status_id = 6
        # 登録確認
        expect(@item).to be_valid
      end
      it '配送料の負担が、選択肢（1:着払い(購入者負担)）の場合、登録できる' do
        # 配送料の負担に選択肢（1:着払い(購入者負担)）を設定
        @item.shipping_fee_status_id = 1
        # 登録確認
        expect(@item).to be_valid
      end
      it '配送料の負担が、選択肢（2:送料込み(出品者負担)）の場合、登録できる' do
        # 配送料の負担に選択肢（2:送料込み(出品者負担)）を設定
        @item.shipping_fee_status_id = 2
        # 登録確認
        expect(@item).to be_valid
      end
      it '発送元の地域が、選択肢（1:北海道）の場合、登録できる' do
        # 発送元の地域に選択肢（1:北海道）を設定
        @item.prefecture_id = 1
        # 登録確認
        expect(@item).to be_valid
      end
      it '発送元の地域が、選択肢（47:沖縄県）の場合、登録できる' do
        # 発送元の地域に選択肢（47:沖縄県）を設定
        @item.prefecture_id = 47
        # 登録確認
        expect(@item).to be_valid
      end
      it '発送までの日数が、選択肢（1:1~2日で発送）の場合、登録できる' do
        # 発送までの日数に選択肢（1:1~2日で発送）を設定
        @item.scheduled_delivery_id = 1
        # 登録確認
        expect(@item).to be_valid
      end
      it '発送までの日数が、選択肢（3:4~7日で発送）の場合、登録できる' do
        # 発送までの日数に選択肢（3:4~7日で発送）を設定
        @item.scheduled_delivery_id = 3
        # 登録確認
        expect(@item).to be_valid
      end
      it '価格が、300以上の場合、登録できる' do
        # 価格に300を設定
        @item.price = 300
        # 登録確認
        expect(@item).to be_valid
      end
      it '価格が、9,999,999以下の場合、登録できる' do
        # 価格に9,999,999を設定
        @item.price = 9_999_999
        # 登録確認
        expect(@item).to be_valid
      end
    end
    context '新規登録：異常系' do
      it '出品画像が、空の場合、登録できない' do
        # 出品画像に空を設定
        @item.image = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が、空の場合、登録できない' do
        # 商品名に空を設定
        @item.name = ''
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '説明が、空の場合、登録できない' do
        # 説明に空を設定
        @item.info = ''
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'カテゴリーが、空の場合、登録できない' do
        # カテゴリーに空を設定
        @item.category_id = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it 'カテゴリーが、未選択の場合、登録できない' do
        # カテゴリーに未選択を設定
        @item.category_id = 0
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it 'カテゴリーが、11以上の場合、登録できない' do
        # カテゴリーに11以上を設定
        @item.category_id = 11
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it '商品の状態が、空の場合、登録できない' do
        # 商品の状態に空を設定
        @item.sales_status_id = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Sales status Select')
      end
      it '商品の状態が、未選択の場合、登録できない' do
        # 商品の状態に未選択を設定
        @item.sales_status_id = 0
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Sales status Select')
      end
      it '商品の状態が、7以上の場合、登録できない' do
        # 商品の状態に7以上を設定
        @item.sales_status_id = 7
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Sales status Select')
      end
      it '配送料の負担が、空の場合、登録できない' do
        # 配送料の負担に空を設定
        @item.shipping_fee_status_id = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Shipping fee status Select')
      end
      it '配送料の負担が、未選択の場合、登録できない' do
        # 配送料の負担に未選択を設定
        @item.shipping_fee_status_id = 0
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Shipping fee status Select')
      end
      it '配送料の負担が、3以上の場合、登録できない' do
        # 配送料の負担に3以上を設定
        @item.shipping_fee_status_id = 3
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Shipping fee status Select')
      end
      it '発送元の地域が、空の場合、登録できない' do
        # 発送元の地域に空を設定
        @item.prefecture_id = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '発送元の地域が、未選択の場合、登録できない' do
        # 発送元の地域に未選択を設定
        @item.prefecture_id = 0
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '発送元の地域が、48以上の場合、登録できない' do
        # 発送元の地域に48以上を設定
        @item.prefecture_id = 48
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '発送までの日数が、空の場合、登録できない' do
        # 発送までの日数に空を設定
        @item.scheduled_delivery_id = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Scheduled delivery Select')
      end
      it '発送までの日数が、未選択の場合、登録できない' do
        # 発送までの日数に未選択を設定
        @item.scheduled_delivery_id = 0
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Scheduled delivery Select')
      end
      it '発送までの日数が、4以上の場合、登録できない' do
        # 発送までの日数に4以上を設定
        @item.scheduled_delivery_id = 4
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Scheduled delivery Select')
      end
      it '価格が、空の場合、登録できない' do
        # 価格に空を設定
        @item.price = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が、300未満の場合、登録できない' do
        # 価格に300未満を設定
        @item.price = 299
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '価格が、10,000,000以上の場合、登録できない' do
        # 価格に10,000,000以上を設定
        @item.price = 10_000_000
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '価格が、半角英字の場合、登録できない' do
        # 価格に半角英字を設定
        @item.price = 'abcXYZ'
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '価格が、全角英字の場合、登録できない' do
        # 価格に全角英字を設定
        @item.price = 'ＡＢＣｘｙｚ'
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '価格が、全角数字の場合、登録できない' do
        # 価格に全角数字を設定
        @item.price = '３００'
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it 'userが、紐付いていない場合、登録できない' do
        # userに空を設定
        @item.user = nil
        # 登録確認
        @item.valid?
        # エラーメッセージ確認
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
