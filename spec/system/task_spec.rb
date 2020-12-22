require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_name:"iefseruighseuigh", detail:"rdsvrtdyr", deadline:"drvhrhtr", status:"drvrvtrtdd",priority:"vtvdtdhdrd")
        visit tasks_path
        expect(page).to have_content 'ppp'
      end
    end
  end
end
