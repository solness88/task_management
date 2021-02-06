require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  user2 = FactoryBot.create(:model_user)
  #let(:admin_user) { FactoryBot.create(:super_user) }
  #let(:test_user) { FactoryBot.create(:ultra_user) }
  let(:task_g) { FactoryBot.create(:seventh_task, user: user2) }
  let(:task_h) { FactoryBot.create(:eighth_task, user: user2) }
  let(:task_i) { FactoryBot.create(:ninth_task, user: user2) }
  let(:task_j) { FactoryBot.create(:tenth_task, user: user2) }
  let(:task_k) { FactoryBot.create(:eleventh_task, user: user2) }
  let(:task_l) { FactoryBot.create(:twelveth_task, user: user2) }
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name:"", detail:"bbb",deadline:"2020-01-01",status:"ddd",priority:"高")
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name:"aaa", detail:"",deadline:"2020-01-01",status:"ddd",priority:"高")
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = task_g
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    before do
      task_g
      task_h
      task_i
      task_j
      task_k
      task_l
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.task_name('３番目に作成したタスク')).to include(task_g)
        expect(Task.task_name('２番目に作成したタスク')).not_to include(task_l)
        expect(Task.task_name('最初に作成したタスク').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status('完了')).to include(task_g)
        expect(Task.status('着手済')).not_to include(task_g)
        expect(Task.status('未着手').count).to eq 3
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.task_name('３番目に作成したタスク') && Task.status('完了')).to include(task_g)
        expect(Task.task_name('タスク') && Task.status('着手')).not_to include(task_g)
        expect(Task.task_name('タスク') && Task.status('完了').count).to eq 2
      end
    end
  end
end
