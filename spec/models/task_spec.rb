require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    @test_user = create(:user)
    @task = build(:task, status: 3)
    @test_user.tasks << @task
  end

  after(:each) do
    @test_user.destroy
  end

  subject {@task}

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
    it 'finds a task by header' do
      task = build(:task, header: 'test', status: 3)
      @test_user.tasks << task
      result = described_class.where(header: 'test')
      expect(result).to eq([task])
    end

    it 'finds a task by status' do
      task = build(:task, status: 2)
      @test_user.tasks << task
      result = described_class.where(status: 2)
      expect(result).to eq([task])
    end
  end
end
