require 'rails_helper'

#homeに飛べるかどうかの確認
RSpec.describe 'Access to static_pages', type: :request do
  context 'static_pages#home' do
    before { get root_path }
    it 'responds successfully' do
      expect(response).to have_http_status 200
    end
    
  end
end

#sign up （新しくユーザーを登録）のページに飛べるか
RSpec.describe 'access to users', type: :request do 
  describe 'GET #new' do
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status 200
    end
  end
end

#ユーザー登録時に有効なリクエストと無効なリクエストを送ったときのテスト

describe 'POST #create' do
    #有効なユーザーの検証
    context 'valid request' do
      #ユーザーが追加される
      it 'adds a user' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      #ユーザーが追加されたときの検証
      context 'adds a user' do
        before { post signup_path, params: { user: attributes_for(:user) } }
        subject { response }
        it { is_expected.to redirect_to user_path(User.last) } #showページにリダイレクトされる
        it { is_expected.to have_http_status 302 } #リダイレクト成功
      end
    end

    #無効なリクエスト
    context 'invalid request' do
      #無効なデータを作成
      let(:user_params) do
        attributes_for(:user, name: '',
                              email: 'user@invalid',
                              password: '',
                              password_confirmation: '')
      end
      #ユーザーが追加されない
      it 'does not add a user' do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
        end
    end
end


