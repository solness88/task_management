require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let(:task_a) { FactoryBot.create(:task) }
    let(:task_b) { FactoryBot.create(:second_task) }
    let(:task_c) { FactoryBot.create(:third_task) }
    let(:task_d) { FactoryBot.create(:fourth_task) }
    let(:task_e) { FactoryBot.create(:fifth_task) }
    let(:task_f) { FactoryBot.create(:sixth_task) }
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
    let!(:task) { FactoryBot.create(:task, task_name: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, task_name: "sample") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task')).to eq 1
      end
    end
  end
end
