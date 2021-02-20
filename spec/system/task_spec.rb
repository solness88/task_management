require 'rails_helper'

def visit_with_http_auth(path)
  username = ENV['USERNAME']
  password = ENV['PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
    @test_user = FactoryBot.create(:test_user)
    visit_with_http_auth new_session_path
    fill_in 'session_email', with: 'tokyo@tokyo.com'
    fill_in 'session_password', with: '12345qwert'
    click_on 'Log in'
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
      @task_a = FactoryBot.create(:task, user: @user)
      @task_b = FactoryBot.create(:second_task, user: @user)
      @task_c = FactoryBot.create(:third_task, user: @user)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        sleep 0.5
        expect(page).to have_content @task_a.detail
        expect(page).to have_content @task_b.detail
        expect(page).to have_content @task_c.detail
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        sleep 0.5
        expect(task_list[0]).to have_content @task_c.task_name
        expect(task_list[1]).to have_content @task_b.task_name
        expect(task_list[2]).to have_content @task_a.task_name
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の最も近いタスクが一番上に表示される' do
        click_on '終了期限でソートする'
        sleep 1
        task_list = all('.task_row')
        expect(task_list[0]).to have_content @task_a.task_name
        expect(task_list[1]).to have_content @task_b.task_name
        expect(task_list[2]).to have_content @task_c.task_name
      end
    end
    context 'タスクが優先順位の降順に並んでいる場合' do
      it '優先順位の最も高いタスクが一番上に表示される' do
        click_on '優先順位でソートする'
        sleep 0.5
        task_list = all('.task_row')
        expect(task_list[0]).to have_content @task_a.priority
        expect(task_list[1]).to have_content @task_b.priority
        expect(task_list[2]).to have_content @task_c.priority
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task_w = FactoryBot.create(:thirteenth_task, user: @user)
        visit task_path(task_w)
        expect(page).to have_content task_w.task_name
      end
    end
  end

  describe '検索機能' do
    before do
      task_d = FactoryBot.create(:fourth_task, user: @user)
      task_e = FactoryBot.create(:fifth_task, user: @user)
      task_f = FactoryBot.create(:sixth_task, user: @user)
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
        fill_in 'user_name', with: 'saitama'
        fill_in 'user_email', with: 'saitama@saitama.com'
        fill_in 'user_password', with:'12345qwert'
        fill_in 'user_password_confirmation', with:'12345qwert'
        click_on 'Create my account'
        expect(page).to have_content "saitama@saitama.com"
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
      fill_in 'session_email', with: 'tokyo@tokyo.com'
      fill_in 'session_password', with: '12345qwert'
      click_on 'Log in'
    end
    context 'ログインに成功した場合' do
      it 'ユーザーの詳細ページに遷移する' do
        expect(page).to have_content @user.email
      end
    end
    context '一般ユーザーが他人の詳細ページに飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(@admin_user)
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
      before do
        click_on 'Logout'
        click_on 'Log in'
        fill_in 'session_email', with: 'osaka@osaka.com'
        fill_in 'session_password', with:'12345qwert'
        click_on 'Log in'
        visit admin_users_path
      end
      it 'ユーザー一覧が表示される' do
        expect(page).to have_content @user.name
        expect(page).to have_content @user.email
        expect(page).to have_content @admin_user.name
        expect(page).to have_content @admin_user.email
        expect(page).to have_content @test_user.name
        expect(page).to have_content @test_user.email
      end
    end
    context '一般ユーザーが管理画面にアクセスしようとすると' do
      before do
        click_on 'Logout'
        click_on 'Log in'
        fill_in 'session_email', with: 'tokyo@tokyo.com'
        fill_in 'session_password', with:'12345qwert'
        click_on 'Log in'
        visit admin_users_path
      end
      it '管理画面にはアクセスできずタスク一覧画面に遷移する' do
        expect(page).to have_content "管理者以外はアクセスできません"
      end
    end
    before do
      click_on 'Logout'
      click_on 'Log in'
      fill_in 'session_email', with: 'osaka@osaka.com'
      fill_in 'session_password', with:'12345qwert'
      click_on 'Log in'
      visit admin_users_path
    end
    context '管理ユーザーがユーザーを新規登録すると' do
      it '新規登録したユーザーの詳細画面が表示される' do
        visit new_admin_user_path
        fill_in 'user_name', with: 'sapporo'
        fill_in 'user_email', with: 'sapporo@sapporo.com'
        fill_in 'user_password', with: '12345qwert'
        fill_in 'user_password_confirmation', with: '12345qwert'
        click_on 'Create my account'
        expect(page).to have_content "sapporo"
        expect(page).to have_content "sapporo@sapporo.com"
      end
    end
    context '管理ユーザーがユーザーの詳細画面にアクセスすると' do
      it 'ユーザーの詳細情報が表示される' do
        visit admin_user_path(@test_user)
        expect(page).to have_content @test_user.name
        expect(page).to have_content @test_user.email
      end
    end
    context '管理ユーザーがユーザー情報を編集すると' do
      it '一覧画面に編集したユーザー情報が表示される' do
        visit edit_admin_user_path(@admin_user)
        fill_in 'user_name', with: 'aomori'
        fill_in 'user_email', with: 'aomori@aomori.com'
        fill_in 'user_password', with: '12345qwert'
        fill_in 'user_password_confirmation', with: '12345qwert'
        check '管理者権限'
        click_on 'Create my account'
        expect(page).to have_content "aomori"
        expect(page).to have_content "aomori@aomori.com"
      end
    end
    context '管理ユーザーがユーザー情報を削除すると' do
      it '削除したユーザー名が一覧画面に表示されなくなる' do
        visit admin_user_path(@test_user)
        page.accept_confirm do
          click_on '削除'
        end
        expect(page).not_to have_content @test_user.name
        expect(page).not_to have_content @test_user.email
      end
    end
  end

  describe 'ラベル機能' do
    before do
      FactoryBot.create(:label)
    end
    context 'タスク作成画面でラベルを選択すると' do
      it '詳細画面に選択したラベルが表示される' do
        visit new_task_path
        fill_in 'task_task_name', with: '東京'
        fill_in 'task_detail', with: 'ニューヨーク'
        fill_in 'task_deadline', with:'002020-01-01'
        select "完了", from: 'task_status'
        select "高", from: 'task_priority'
        check("task[label_ids][]")
        #check "label1"
        click_on '登録する'
        click_on '登録する'
        click_on '詳細', match: :first
        expect(page).to have_content "label1"
      end
    end
  end
end
