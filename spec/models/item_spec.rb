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
        # 価格に300以上を設定
        @item.price = 300
        # 登録確認
        expect(@item).to be_valid
      end
      it '価格が、9999999以下の場合、登録できる' do
        # 価格に9999999以下を設定
        @item.price = 9999999
        # 登録確認
        expect(@item).to be_valid
      end
    end
    context '新規登録：異常系' do
      it '全項目が、入力ありの場合、登録できる' do
        @item.valid?
        expect(@item.errors.full_messages).to include("")
      end
      it '' do
      end
    end
  end
end
