require 'rails_helper'
require 'capybara/rails'

RSpec.describe "TaskReports", type: :request do
  describe 'integration test' do
    it 'Check if list comment' do
      user = create(:user)
      profile = create(:profile, user:user)
      login_as(user)
      visit '/task_reports'
      expect(page).to have_selector('h1', text: 'Completed Tasks')
    end
  end
end
