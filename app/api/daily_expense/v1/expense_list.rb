module DailyExpense
  module V1
    class ExpenseList < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      before do
        authenticate!
      end
      resource :expense do
        desc 'Return list of expenses created'
        get do
          expense_list = @current_user.expenses.all
          present expense_list, with: DailyExpense::Entities::Expense
        end

        desc 'Return a specific expense list'
          route_param :id do
              get do
                begin
                  expense_particular_list = @current_user.expenses.find(params[:id])
                  present expense_particular_list
                    rescue ActiveRecord::RecordNotFound
                      error!({ status: :error, message: :not_found }, 404)
                end
              end
            end
        desc 'Create a new category'
          params do
            requires :date, type: Date, desc: 'Enter a Date'
            requires :item, type: String, desc: 'Enter a item name'
            requires :method, type: String, desc: 'Enter a method type of payment done either debit or cash'
            requires :amount, type: String, desc: 'Enter a amount'
            requires :category_id, type: Integer, desc: 'Enter a category id'
            # requires :user_id, type: Integer, desc: 'Enter a user id'
          end
          post '/new' do
            begin
              expense_category = Category.find(params[:category_id])
              expense_user = User.find(@current_user.id)
              if expense_category.present? && expense_user.present?
                  expense = Expense.create!(date: params[:date], item: params[:item], method: params[:method], amount: params[:amount], category_id: params[:category_id], user_id: @current_user.id)
                if expense.save
                  status 200
                      present expense, with: DailyExpense::Entities::Expense
                else
                  status 400
                  present failure: "Expense was not created succesfully"
                end
              end
              rescue ActiveRecord::RecordNotFound
                error!({ status: :error, message: :given_category_id_or_user_id_was_not_found }, 404)
            end
          end 
        desc 'Edit Expense'
          params do
            requires :id, type: Integer, desc: 'enter id to update expense'
            optional :date, type: Date, desc: 'Enter a Date'
            optional :item, type: String, desc: 'Enter a item name'
            optional :method, type: String, desc: 'Enter a method type of payment done either debit or cash'
            optional :amount, type: String, desc: 'Enter a amount'
            optional :category_id, type: Integer, desc: 'Enter a category id'
            # requires :user_id, type: Integer, desc: 'Enter a user id'
          end
          route_param :id do
            put '/edit' do
              begin
                expense = @current_user.expenses.find(params[:id])
                expense_category = Category.find(params[:category_id])
                expense_user = User.find(current_user.id)
                if expense.present? && expense_user.present?
                  if expense.update(date: params[:date], item: params[:item], method: params[:method], amount: params[:amount], category_id: params[:category_id], user_id: @current_user.id)
                        status 200
                        present expense, with: DailyExpense::Entities::Expense
                  else
                    status 400
                    present failure: "Expense was not updated succesfully"
                  end
                end
                rescue ActiveRecord::RecordNotFound
                  error!({ status: :error, message: :given_category_id_or_user_id_was_not_found }, 404)
              end
            end 
          end
        desc 'Delete a specific expense from list'
        route_param :id do
        delete do
          begin
            expense_list = @current_user.expenses.find(params[:id])
          if expense_list.destroy
            status 200
            present expense_list, with: DailyExpense::Entities::Expense
          else
            status 400
            present delete: "Expense was not deleted succesfully"
          end
            rescue ActiveRecord::RecordNotFound
              error!({ status: :error, message: :not_found }, 404)
            end
        end
      end
      end
    end
  end
end