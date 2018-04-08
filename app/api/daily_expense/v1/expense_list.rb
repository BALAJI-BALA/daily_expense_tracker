module DailyExpense
  module V1
    class ExpenseList < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      resource :expense do
        desc 'Return list of expenses created'
        get do
          expense_list = Expense.all
          present expense_list, with: DailyExpense::Entities::Expense
        end

        desc 'Return a specific expense list'
          route_param :id do
            get do
              expense_particular_list = Expense.find(params[:id])
              present expense_particular_list
            end
          end
      end
    end
  end
end