require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:task_a) { FactoryBot.create(:task) }
  let(:task_b) { FactoryBot.create(:second_task) }
  describe '新規作成機能' do
    before do
      visit new_task_path
      fill_in 'task_task_name', with: '東京'
      fill_in 'task_detail', with: 'ニューヨーク'
      fill_in 'task_deadline', with: '台北'
      fill_in 'task_status', with: 'バンコク'
      fill_in 'task_priority', with: 'バーミンガム'
      click_on '登録する'
      end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        expect(page).to have_content "ニューヨーク"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content "bbbbbb"
      end
    end
    # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       before do
         visit task_path(task_b)
       end
       it '該当タスクの内容が表示される' do
         expect(page).to have_content "高雄"
       end
     end
  end
end
