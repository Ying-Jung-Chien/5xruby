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
    it 'finds a task by header' do
      task = create(:task, header: 'test')
      result = described_class.where(header: 'test')
      expect(result).to eq([task])
    end

    it 'finds a task by status' do
      task = create(:task, status: 2)
      result = described_class.where(status: 2)
      expect(result).to eq([task])
    end
  end
end
