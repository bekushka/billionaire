require 'rails_helper'

RSpec.feature 'User see profile another user', type: :feature do
  let(:user) { FactoryBot.create :user, name: 'Beka' }
  let(:other_user) { FactoryBot.create :user, name: 'Bekushka' }

  let!(:first_game) {
    FactoryBot.create(
      :game, id: 1, user: other_user, finished_at: Time.now, current_level: 5, prize: 1_000
    )
  }

  let!(:second_game) {
    FactoryGirl.create(
      :game, id: 2, user: other_user, finished_at: Time.now, current_level: 15, prize: 1_000_000
    )
  }

  scenario 'success' do
    visit '/'

    click_link other_user.name

    expect(page).to have_current_path "/users/#{other_user.id}"
    expect(page).to have_content "#{other_user.name}"
    expect(page).to_not have_content 'Сменить имя и пароль'

    expect(page).to have_content 'выигрыш'
    expect(page).to have_content "#{I18n.l(first_game.created_at, format: :short)}"
    expect(page).to have_content '15'
    expect(page).to have_content '1 000 000 ₽'

    expect(page).to have_content 'деньги'
    expect(page).to have_content "#{I18n.l(second_game.created_at, format: :short)}"
    expect(page).to have_content '5'
    expect(page).to have_content '1 000 ₽'
  end
end