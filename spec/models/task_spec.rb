require 'rails_helper'

RSpec.describe Task, type: :model do
  subject {create(:task)}

  describe "Validations" do
    context 'is not valid without a header' do
      it { is_expected.to validate_presence_of(:header) }
    end

    context 'is not valid without a content' do
      it { is_expected.to validate_presence_of(:content) }
    end

    context 'is not valid without a priority' do
      it { is_expected.to validate_presence_of(:priority) }
    end

    context 'is not valid without a status' do
      it { is_expected.to validate_presence_of(:status) }
    end

    context 'is not valid without a start_time' do
      it { is_expected.to validate_presence_of(:start_time) }
    end

    context 'is not valid without a end_time' do
      it { is_expected.to validate_presence_of(:end_time) }
    end
  end

  describe "Search" do
    it 'finds a searched task by header' do
      tasks = create_list(:task, 10)
      results = Task.search(2, search: tasks[1].header, sort:'id', dir:'asc')
      expect(results[0]).to eq(tasks[1])
    end

    # it 'finds a searched task by status' do
    #   tasks = create_list(:task, 10)
    #   results = Task.search(3, option: '0', sort:'id', dir:'asc')
    #   ans = Task.where("status = 0").order("id asc")
    #   puts ans[0].header
    #   expect(results[0]).to eq(ans[0])
    # end
  end
end
