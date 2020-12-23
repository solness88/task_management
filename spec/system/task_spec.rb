require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    before do
      visit new_task_path
      fill_in ‘タスク名’, with: ‘password’
      fill_in ‘詳細’, with: ‘detail’
      fill_in ‘期限’, with: ‘deadline’
      fill_in ‘状況’, with: ‘situation’
      fill_in ‘優先順位’, with: ‘priority’
      click_on '登録する'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:task,
                                  task_name: "東京",
                                  detail: "大阪",
                                  deadline: "神戸",
                                  status: "岡山",
                                    priority: "福岡")
        expect(page).to have_content "task"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task,
                                  task_name: "東京",
                                  detail: "大阪",
                                  deadline: "神戸",
                                  status: "岡山",
                                  priority: "福岡")
        visit tasks_path
        expect(page).to have_content "task"
      end
    end
  end
end
