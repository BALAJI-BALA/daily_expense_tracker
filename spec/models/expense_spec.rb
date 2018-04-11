require 'faker'
require 'rails_helper'
RSpec.describe Expense, :type => :model do
	
	user = User.create(:email => Faker::Internet.email , :password => 'pw1234',
                         :password_confirmation => 'pw1234')
	category = Category.create(:name => "milk")
	subject {
		described_class.create(date: Time.now.strftime("%Y/%m/%d"), item: "Lorem ipsum",
                      method: "cash", amount: 99.99, user_id: user.id, category_id: category.id)
	}
	describe "Associations" do
	  it { should belong_to(:user) }
	  it { should belong_to(:category) }
	end
	describe "Validations" do
    	it { should validate_presence_of(:date) }
    	it { should validate_presence_of(:item) }
    	it { should validate_presence_of(:method) }
    	it { should validate_presence_of(:amount) }
  	end	

  	it "is valid with valid attributes" do
		expect(subject).to be_valid
	end

	it "is not valid without a date" do
		subject.date = nil
		expect(subject).to_not be_valid
	end

	it "is not valid without a item" do
		subject.item = nil
		expect(subject).to_not be_valid
	end

	it "is not valid without a method" do
		subject.method = nil
		expect(subject).to_not be_valid
	end

	it "is not valid without a amount" do
		subject.amount = nil
		expect(subject).to_not be_valid
	end

	it "is not valid without a user" do
		subject.user = nil
		expect(subject).to_not be_valid
	end

	it "is not valid without a category" do
		subject.category = nil
		expect(subject).to_not be_valid
	end
end
