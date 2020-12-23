require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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
