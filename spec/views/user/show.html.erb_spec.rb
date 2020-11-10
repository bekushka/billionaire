require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user, name: 'Beka') }
  let(:another_user) { create(:user, name: 'Bekushka') }

    before(:each) do
      assign(:user, user)
      sign_in user
      assign(:games, [build_stubbed(:game)])

      render
    end

    it 'user see his name' do
      expect(rendered).to match('Beka')
    end

    it 'renders change password' do
      expect(rendered).to match('Сменить имя и пароль')
    end

    it 'renders game fragments' do
      expect(rendered).to match('в процессе')
    end


    before(:each) do
      assign(:user, another_user)
      assign(:games, [build_stubbed(:game)])

      render
    end

    it 'renders second user name' do
      expect(rendered).to match('Bekushka')
    end

    it 'renders game fragments' do
      expect(rendered).to match('в процессе')
    end

    it 'renders change password' do
      expect(rendered).not_to match('Сменить имя и пароль')
    end
end