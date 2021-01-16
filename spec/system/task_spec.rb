require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV['USERNAME']
  password = ENV['PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'タスク管理機能', type: :system do
  let(:task_a) { FactoryBot.create(:task) }
  let(:task_b) { FactoryBot.create(:second_task) }
  let(:task_c) { FactoryBot.create(:third_task) }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit_with_http_auth new_task_path
        fill_in 'task_task_name', with: '東京'
        fill_in 'task_detail', with: 'ニューヨーク'
        fill_in 'task_deadline', with:'002020-01-01'
        select "完了", from: 'task_status'
        fill_in 'task_priority', with: 'バーミンガム'
        click_on '登録する'
        click_on '登録する'
        expect(page).to have_content "バーミンガム"
      end
    end
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content "ロンドン"
        expect(page).to have_content "ヤンゴン"
        expect(page).to have_content "ソウル"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "最初に作成したタスク"
        expect(task_list[1]).to have_content "２番目に作成したタスク"
        expect(task_list[2]).to have_content "３番目に作成したタスク"
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の最も近いタスクが一番上に表示される' do
        task_list = all('.task_row')
        click_on '終了期限でソートする'
        expect(task_list[0]).to have_content "期限が最も遅いタスク"
        expect(task_list[1]).to have_content "期限が２番目に早いタスク"
        expect(task_list[2]).to have_content "期限が最も早いタスク"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task_c)
        expect(page).to have_content "ソウル"
      end
    end
  end
end
