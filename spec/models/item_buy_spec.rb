require 'rails_helper'

RSpec.describe ItemBuy, type: :model do
  before do
    # 商品購入情報を生成
    @item_buy = FactoryBot.build(:item_buy)
  end

  describe '商品購入情報登録' do
    context '商品購入情報登録：正常系' do
      it '全項目が、入力ありの場合、登録できる' do
        @item_buy.user_id = nil
        # 登録確認
        expect(@item_buy).to be_valid
      end
    end
  end
end
