require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let(:task_c) { FactoryBot.new(:third_task) }
    let(:task_d) { FactoryBot.create(:fourth_task) }
    let(:task_e) { FactoryBot.create(:fifth_task) }
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
end
