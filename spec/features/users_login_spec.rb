require 'rails_helper'

RSpec.feature "UsersLogin", type: :feature do

  before do
      @user = FactoryBot.create(:user)
  end

  scenario "ログインした後にメニューバーの表示内容が変わること" do
    #Request Specでの書き方が分からなかったためFeatureに書きます..
    # 1.ログイン用のパスを開く
    # 2.セッション用パスに有効な情報をpostする
    # 3.ログイン用リンクが表示されなくなったことを確認する
    # 4.ログアウト用リンクが表示されていることを確認する
    # 5.プロフィール用リンクが表示されていることを確認する

    visit login_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(page).to_not have_css("a", text: "Log in")
    expect(page).to have_css("a", text: "Log out")
  end
end
