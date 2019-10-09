describe 'DELETE #destroy' do
  it 'log out and redirect to root page' do
    delete logout_path
    expect(response).to redirect_to root_path
    expect(is_logged_in?).to be_falsey #ここでセッションの値をテストしています。
  end
end