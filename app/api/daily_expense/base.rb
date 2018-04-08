module DailyExpense
	class Base < Grape::API
		mount DailyExpense::V1::ExpenseList
		mount DailyExpense::V1::CategoryList
	end
end