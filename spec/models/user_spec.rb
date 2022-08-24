require 'rails_helper'

RSpec.describe User, type: :model do
  subject {User.new(name: "Jim", 
                    password: "Abcd1234",
                    position: "user")}

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a position" do
      subject.position = nil
      expect(subject).to_not be_valid
    end
  end
end
