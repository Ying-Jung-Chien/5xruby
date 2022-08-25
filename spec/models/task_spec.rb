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
end
