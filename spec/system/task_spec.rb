require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:task_a) { FactoryBot.create(:task) }
  let(:task_b) { FactoryBot.create(:second_task) }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_task_name', with: '東京'
        fill_in 'task_detail', with: 'ニューヨーク'
        fill_in 'task_deadline', with:'002020-01-01'
        fill_in 'task_status', with: 'バンコク'
        fill_in 'task_priority', with: 'バーミンガム'
        click_on '登録する'
        click_on '登録する'
        expect(page).to have_content "バーミンガム"
      end
    end
  end
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content "ロンドン"
        expect(page).to have_content "ソウル"
        expect(page).to have_content "ジャカルタ"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "一番上に表示したいタスク"
        expect(task_list[1]).to have_content "上から２番目のタスク"
        expect(task_list[2]).to have_content "上から３番目のタスク"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(task_b)
         expect(page).to have_content "ヤンゴン"
       end
     end
  end
end
