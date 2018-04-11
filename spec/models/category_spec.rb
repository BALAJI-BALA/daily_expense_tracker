require 'rails_helper'

RSpec.describe Category, :type => :model do
  subject { described_class.new(name: "milk") }

  describe "Associations" do
    it { should have_many(:expenses) }
  end


  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end