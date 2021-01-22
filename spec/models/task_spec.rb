require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let(:task_a) { FactoryBot.create(:task) }
  let(:task_b) { FactoryBot.create(:second_task) }
  let(:task_c) { FactoryBot.create(:third_task) }
  let(:task_d) { FactoryBot.create(:fourth_task) }
  let(:task_e) { FactoryBot.create(:fifth_task) }
  let(:task_f) { FactoryBot.create(:sixth_task) }
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name:"", detail:"bbb",deadline:"2020-01-01",status:"ddd",priority:"eee")
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name:"aaa", detail:"",deadline:"2020-01-01",status:"ddd",priority:"eee")
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name:"aaa", detail:"bbb",deadline:"2020-01-01",status:"ddd",priority:"eee")
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    before do
      task_a
      task_b
      task_c
      task_d
      task_e
      task_f
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.task_name('３番目に作成したタスク')).to include(task_a)
        expect(Task.task_name('２番目に作成したタスク')).not_to include(task_f)
        expect(Task.task_name('最初に作成したタスク').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status('完了')).to include(task_a)
        expect(Task.status('着手済')).not_to include(task_a)
        expect(Task.status('未着手').count).to eq 3
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.task_name('３番目に作成したタスク') && Task.status('完了')).to include(task_a)
        expect(Task.task_name('タスク') && Task.status('着手')).not_to include(task_a)
        expect(Task.task_name('タスク') && Task.status('完了').count).to eq 2
      end
    end
  end
end
