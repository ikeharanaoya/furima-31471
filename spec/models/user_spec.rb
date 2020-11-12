require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    # ユーザーを生成
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録（ユーザー情報）' do
    context '新規登録：正常系' do
      it "全項目が、入力ありの場合、登録できる" do
        expect(@user).to be_valid
      end
      it "メールアドレスが、重複しない場合、登録できる" do
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
      it "パスワードが、6文字以上（半角英数字混合）の場合、登録できる" do
        # パスワードに６文字以上を設定
        @user.password = "pass12"
        @user.password_confirmation = "pass12"
        # 登録確認
        expect(@user).to be_valid
      end
    end
    context '新規登録：異常系' do
      it "ニックネームが、空の場合、登録できない" do
        # ニックネームに空を設定
        @user.nickname = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "メールアドレスが、空の場合、登録できない" do
        # メールアドレスに空を設定
        @user.email = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスが、重複する場合、登録できない" do
        # 共通のメールアドレス
        EMAIL = "test123@test.com"
        # メールアドレスを設定
        @user.email = EMAIL
        # DBに保存
        @user.save
        # 新規ユーザー生成
        another_user = FactoryBot.build(:user)
        # 違うメールアドレスを設定
        another_user.email = EMAIL
        # 登録確認
        another_user.valid?
        # エラーメッセージ確認
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "メールアドレスが、「@」がない場合、登録できない" do
        # メールアドレスに空を設定
        @user.email = "test123test.com"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "パスワードが、空の場合、登録できない" do
        # パスワードに空を設定
        @user.password = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "パスワードが、5文字以下の場合、登録できない" do
        # パスワードに5文字を設定
        @user.password = "abc12"
        @user.password_confirmation = "abc12"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードが、半角数字のみの場合、登録できない" do
        # パスワードに半角数字のみを設定
        @user.password = "123789"
        @user.password_confirmation = "123789"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it "パスワードが、半角英字のみの場合、登録できない" do
        # パスワードに半角数字のみを設定
        @user.password = "abcXYZ"
        @user.password_confirmation = "abcXYZ"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it "パスワード（確認用）が、空の場合、登録できない" do
        # パスワード（確認用）に空を設定
        @user.password_confirmation = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "パスワードとパスワード（確認用）が、違う場合、登録できない" do
        # パスワードとパスワード（確認用）に違う値を設定
        @user.password = "abd123"
        @user.password_confirmation = "789xyz"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
  describe 'ユーザー新規登録（本人情報確認）' do
    context '新規登録：正常系' do
      it "ユーザー本名が、漢字の場合、登録できる" do
        # ユーザー本名に漢字を設定
        @user.last_name = "山田"
        @user.first_name = "太郎"
        # 登録確認
        expect(@user).to be_valid
      end
      it "ユーザー本名が、ひらがなの場合、登録できる" do
        # ユーザー本名にひらがなを設定
        @user.last_name = "やまだ"
        @user.first_name = "たろう"
        # 登録確認
        expect(@user).to be_valid
      end
      it "ユーザー本名が、全角カタカナの場合、登録できる" do
        # ユーザー本名に全角カタカナを設定
        @user.last_name = "ヤマダ"
        @user.first_name = "タロウ"
        # 登録確認
        expect(@user).to be_valid
      end
      it "ユーザー本名のフリガナが、全角カタカナの場合、登録できる" do
        # ユーザー本名のフリガナに全角カタカナを設定
        @user.last_name_kana = "ヤマダ"
        @user.first_name_kana = "タロウ"
        # 登録確認
        expect(@user).to be_valid
      end
    end
    context '新規登録：異常系' do
      it "ユーザー本名（苗字）が、空の場合、登録できない" do
        # ユーザー本名（苗字）に空を設定
        @user.last_name  = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "ユーザー本名（苗字）が、半角カタカナの場合、登録できない" do
        # ユーザー本名（苗字）に半角カタカナを設定
        @user.last_name  = "ﾔﾏﾀﾞ"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it "ユーザー本名（苗字）が、半角英数字の場合、登録できない" do
        # ユーザー本名（苗字）に半角英数字を設定
        @user.last_name  = "abd123"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it "ユーザー本名（名前）が、空の場合、登録できない" do
        # ユーザー本名（名前）に空を設定
        @user.first_name  = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "ユーザー本名（名前）が、半角カタカナの場合、登録できない" do
        # ユーザー本名（名前）に半角カタカナを設定
        @user.first_name  = "ﾀﾛｳ"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it "ユーザー本名（名前）が、半角英数字の場合、登録できない" do
        # ユーザー本名（名前）に半角英数字を設定
        @user.first_name  = "abc123"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it "ユーザー本名のフリガナ（苗字）が、空の場合、登録できない" do
        # ユーザー本名のフリガナ（苗字）に空を設定
        @user.last_name_kana  = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "ユーザー本名のフリガナ（苗字）が、漢字の場合、登録できない" do
        # ユーザー本名のフリガナ（苗字）に漢字を設定
        @user.last_name_kana  = "山田"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（苗字）が、ひらがなの場合、登録できない" do
        # ユーザー本名のフリガナ（苗字）にひらがなを設定
        @user.last_name_kana  = "やまだ"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（苗字）が、半角カタカナの場合、登録できない" do
        # ユーザー本名のフリガナ（苗字）に半角カタカナを設定
        @user.last_name_kana  = "ﾔﾏﾀﾞ"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（苗字）が、半角英数字の場合、登録できない" do
        # ユーザー本名のフリガナ（苗字）に半角英数字を設定
        @user.last_name_kana  = "abd123"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（名前）が、空の場合、登録できない" do
        # ユーザー本名のフリガナ（名前）に空を設定
        @user.first_name_kana  = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "ユーザー本名のフリガナ（名前）が、漢字の場合、登録できない" do
        # ユーザー本名のフリガナ（名前）に漢字を設定
        @user.first_name_kana  = "太郎"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（名前）が、ひらがなの場合、登録できない" do
        # ユーザー本名のフリガナ（名前）にひらがなを設定
        @user.first_name_kana  = "たろう"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（名前）が、半角カタカナの場合、登録できない" do
        # ユーザー本名のフリガナ（名前）に半角カタカナを設定
        @user.first_name_kana  = "ﾀﾛｳ"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
      end
      it "ユーザー本名のフリガナ（名前）が、半角英数字の場合、登録できない" do
        # ユーザー本名のフリガナ（名前）に半角英数字を設定
        @user.first_name_kana  = "abc123"
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
      end
      it "生年月日が、空の場合、登録できない" do
        # 生年月日に空を設定
        @user.birth_date  = ""
        # 登録確認
        @user.valid?
        # エラーメッセージ確認
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
