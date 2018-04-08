module DailyExpense
	module Entities
		class Expense < Grape::Entity
			expose :id
			expose :date
			expose :item
			expose :method
			expose :amount
			expose (:category) { |model, options| model.category.name }
			expose (:user) { |model, options| model.user.email }
		end
	end
end