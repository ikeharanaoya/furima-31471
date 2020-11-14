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
    end
  end
end
