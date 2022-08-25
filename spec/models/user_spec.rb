require 'rails_helper'

RSpec.describe User, type: :model do
  subject {create(:user)}

  describe "Validations" do
    context 'is not valid without a name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'is not valid without a password' do
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'is not valid without a position' do
      it { is_expected.to validate_presence_of(:position) }
    end
  end
end
