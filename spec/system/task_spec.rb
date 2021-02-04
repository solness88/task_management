require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV['USERNAME']
  password = ENV['PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'タスク管理機能', type: :system do
  user = FactoryBot.create(:user)
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:task_a) { FactoryBot.create(:task, user: user) }
  let(:task_b) { FactoryBot.create(:second_task, user: user) }
  let(:task_c) { FactoryBot.create(:third_task, user: user) }
  let(:task_d) { FactoryBot.create(:fourth_task, user: user) }
  let(:task_e) { FactoryBot.create(:fifth_task, user: user) }
  let(:task_f) { FactoryBot.create(:sixth_task, user: user) }
  before do
    visit_with_http_auth new_user_path
    fill_in 'user_name', with: 'test'
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: '12345qwert'
    fill_in 'user_password_confirmation', with: '12345qwert'
    click_on 'Create my account'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_task_name', with: '東京'
        fill_in 'task_detail', with: 'ニューヨーク'
        fill_in 'task_deadline', with:'002020-01-01'
        select "完了", from: 'task_status'
        select "高", from: 'task_priority'
        click_on '登録する'
        click_on '登録する'
        expect(page).to have_content "ニューヨーク"
      end
    end
  end
  describe '一覧表示機能' do
    before do
      task_a
      task_b
      task_c
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        sleep 0.5
        expect(page).to have_content "期限が最も遅いタスク"
        expect(page).to have_content "２番目に作成したタスク"
        expect(page).to have_content "期限が最も早いタスク"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        sleep 0.5
        expect(task_list[0]).to have_content "最初に作成したタスク"
        expect(task_list[1]).to have_content "２番目に作成したタスク"
        expect(task_list[2]).to have_content "３番目に作成したタスク"
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の最も近いタスクが一番上に表示される' do
        save_and_open_page
        click_on '終了期限でソートする'
        sleep 0.5
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "期限が最も早いタスク"
        expect(task_list[1]).to have_content "期限が２番目に早いタスク"
        expect(task_list[2]).to have_content "期限が最も遅いタスク"
      end
    end
    context 'タスクが優先順位の降順に並んでいる場合' do
      it '優先順位の最も高いタスクが一番上に表示される' do
        click_on '優先順位でソートする'
        sleep 0.5
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "高"
        expect(task_list[1]).to have_content "中"
        expect(task_list[2]).to have_content "低"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task_c)
        expect(page).to have_content "最初に作成したタスク"
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
  describe 'ユーザー登録機能' do
    before do
      visit tasks_path
      click_on 'Logout'
    end
    context 'ユーザーを新規登録した場合' do
      it '作成したユーザーが一覧ページに表示される' do
        visit_with_http_auth new_user_path
        fill_in 'user_name', with: 'tokyo'
        fill_in 'user_email', with: 'tokyo@tokyo.com'
        fill_in 'user_password', with:'12345qwert'
        fill_in 'user_password_confirmation', with:'12345qwert'
        click_on 'Create my account'
        expect(page).to have_content "tokyo@tokyo.com"
      end
    end
    context 'ログインせずタスク一覧画面に飛ぼうとしたとき' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content "Log in"
      end
    end
  end
  describe 'セッション機能' do
    before do
      tasks_path
      click_link 'Logout'
      visit_with_http_auth new_session_path
      fill_in 'session_email', with: 'test@test.com'
      fill_in 'session_password', with: '12345qwert'
      click_on 'Log in'
    end
    context 'ログインに成功した場合' do
      it 'ユーザーの詳細ページに遷移する' do
        expect(page).to have_content "test@test.com"
      end
    end
    context '一般ユーザーが他人の詳細ページに飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        admin_user
        visit user_path(admin_user)
        expect(page).to have_content "タスク名"
      end
    end
    context 'ログアウトすると' do
      it 'ログイン画面に遷移する' do
        click_on 'Logout'
        expect(page).to have_content "Email"
        expect(page).to have_content "Password"
      end
    end
  end
  describe '管理画面' do
    context '管理ユーザーが管理画面にアクセスすると' do
      it 'ユーザー一覧が表示される' do
        click_on 'Logout'
        visit new_admin_user_path
        save_and_open_page
        fill_in 'user_name', with: 'osaka'
        fill_in 'user_email', with: 'osaka@osaka.com'
        fill_in 'user_password', with:'12345qwert'
        fill_in 'user_password_confirmation', with:'12345qwert'
        check('admin', allow_label_click: true)
        click_on 'Create my account'
        visit admin_users_path
        expect(page).to have_content "osaka"
        expect(page).to have_content "osaka@osaka.com"
      end
    end
  end
end
