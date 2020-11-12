require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザーを生成
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録（ユーザー情報）' do
    context '新規登録：正常形' do
      it "全項目が入力ありの場合、登録できる。" do
        expect(@user).to be_valid
      end
      it "メールアドレスが違う場合は登録できる" do
        # メールアドレスを設定
        @user.email = "test123@test.com"
        # DBに保存
        @user.save
        # 新規ユーザー生成
        another_user = FactoryBot.build(:user)
        # 違うメールアドレスを設定
        another_user.email = "sample@sample.com"
        # 登録確認
        expect(another_user).to be_valid
      end
      it "パスワードは、6文字以上（半角英数字混合）で登録できる" do
        # パスワードに６文字以上を設定
        @user.password = "pass12"
        @user.password_confirmation = "pass12"
        # 登録確認
        expect(@user).to be_valid
      end
    end
    context '新規登録：異常形' do
      it "" do
      end
    end
  end
end
