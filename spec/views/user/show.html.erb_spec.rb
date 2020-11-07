require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user, name: 'Bekzod') }

    before(:each) do
      assign(:user, user)
      sign_in user
      assign(:games, [build_stubbed(:game)])

      render
    end

  it 'user see his name' do
    expect(rendered).to match('Bekzod')
  end

  it 'renders change password' do
    expect(rendered).to match('Сменить имя и пароль')
  end

  it 'renders game fragments' do
    expect(rendered).to match('в процессе')
  end
end