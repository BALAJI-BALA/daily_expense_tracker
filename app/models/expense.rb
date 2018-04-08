class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  
  attr_accessor :new_category_name
  before_save :create_category_from_name

  validates_presence_of :date
  validates_presence_of :item 
  validates_presence_of :method 
  validates_presence_of :amount 
  validate :category_or_new

  def category_or_new
	unless category_id.blank? ^ new_category_name.blank?
	errors.add(:base, "Specify a category_id or create a new one")
	end
  end

  def create_category_from_name
    create_category(name: new_category_name) unless new_category_name.blank?
  end
end
