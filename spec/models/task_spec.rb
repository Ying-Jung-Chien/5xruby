require 'rails_helper'

RSpec.describe Task, type: :model do
  subject {Task.new(header: "test", 
                    content: "Abcd1234",
                    priority: 0,
                    status: 1,
                    start_time: DateTime.now,
                    end_time: DateTime.now + 1.week,)}

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a header" do
      subject.header = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a content" do
      subject.content = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a priority" do
      subject.priority = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a status" do
      subject.status = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a start_time" do
      subject.start_time = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a end_time" do
      subject.end_time = nil
      expect(subject).to_not be_valid
    end
  end
end
