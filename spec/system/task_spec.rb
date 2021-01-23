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
  let(:task_d) { FactoryBot.create(:fourth_task) }
  let(:task_e) { FactoryBot.create(:fifth_task) }
  let(:task_f) { FactoryBot.create(:sixth_task) }
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
    before(:each) do
      task_a
      task_b
      task_c
      task_d
      task_e
      task_f
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
        expect(task_list[0]).to have_content "タスク3"
        expect(task_list[1]).to have_content "タスク2"
        expect(task_list[2]).to have_content "タスク1"
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の最も近いタスクが一番上に表示される' do
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "期限が最も遅いタスク"
        expect(task_list[1]).to have_content "期限が２番目に早いタスク"
        expect(task_list[2]).to have_content "期限が最も早いタスク"
      end
    end
    context 'タスクが優先順位の降順に並んでいる場合' do
      it '優先順位の最も高いタスクが一番上に表示される' do
        click_on '優先順位でソートする'
        task_list = all('.task_row')
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
  describe '検索機能' do
    before do
      task_d
      task_e
      task_f
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        fill_in 'task_name', with: 'タスク'
        expect(page).to have_content 'タスク1の詳細'
        expect(page).to have_content 'タスク2の詳細'
        expect(page).to have_content 'タスク3の詳細'
        click_on '検索'
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        select "未着手", from: 'status'
        expect(page).to have_content 'タスク2の詳細'
        expect(page).to have_content 'タスク3の詳細'
        click_on '検索'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        fill_in 'task_name', with: 'タスク1'
        select "完了", from: 'status'
        expect(page).to have_content 'タスク1の詳細'
        click_on '検索'
      end
    end
  end
end
