module DailyExpense
  module V1
    class CategoryList < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      	desc 'Return list of categories'
		resource :categories do
			get do
				category_list = Category.all
				if category_list.present?
					status 200
					present category_list, with: DailyExpense::Entities::Category
				else
					status 400
					present failure: "No category was found please create a new one"
				end
			end
		desc 'Return a specific category list'
			route_param :id do
				get do
				  expense_category_list = Category.find(params[:id])
				  status 200
				  present expense_category_list, with: DailyExpense::Entities::Category
				rescue ActiveRecord::RecordNotFound
					error!({ status: :error, message: :not_found }, 404)
				end
			end
		desc 'Create a new category'
				params do
					requires :name, type: String, desc: 'Enter a category name'
				end
			post '/new' do
				category = Category.create(name: params[:name])
				if category.save
					status 200
	        		present category, with: DailyExpense::Entities::Category
	        	else
					status 400
	        		present failure: "Category was not created succesfully"
        		end
			end	
		desc 'Edit a category'
				params do
	      			requires :name, type: String,  desc: "Enter category name to edit."
	    		end
			route_param :id do
				post 'edit' do
				  expense_category_list = Category.find(params[:id])
					if expense_category_list.update(name: params[:name])
						status 200
						present expense_category_list, with: DailyExpense::Entities::Category
					else
						status 400
						present failure: "Category was not edited succesfully"
					end
				  	rescue ActiveRecord::RecordNotFound
    					error!({ status: :error, message: :not_found }, 404)
				end
			end
		desc 'Delete a specific category from list'
			params do
      			requires :id, type: Integer,  desc: "Enter category id to delete."
    		end
			delete do
			  	expense_category_list = Category.find(params[:id])
			  	if expense_category_list.destroy
					status 200
					present expense_category_list, with: DailyExpense::Entities::Category
				else
					status 400
					present delete: "Category was not deleted succesfully"
				end
			  	rescue ActiveRecord::RecordNotFound
					error!({ status: :error, message: :not_found }, 404)
			end
		end
  	end
  end
end	