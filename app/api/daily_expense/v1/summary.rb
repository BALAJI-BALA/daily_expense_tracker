module DailyExpense
  	module V1
    	class Summary < Grape::API
    		version 'v1', using: :path
      	format :json
 		 prefix :api
 		 before do
   		 	authenticate!
  		end
	      desc 'Enter approriate date,month and year to find the expense'
	      	resource :summary do
			    params do
			      requires :date_month_year, type: String, desc: 'Enter Date in format 2018-04-09'
			    end
			    post "/expense_by_date" do
					if params['date_month_year'].present?
						date = Date.parse(params['date_month_year'])
			  			date = date.to_s
			  			@summary = @current_user.expenses.where(date: date)
			  			@total = @summary.sum(:amount)
			  			if @total.present?
							status 200
							present total: @total, list_by_date: @summary
						else
							error_msg = 'No Records were found,Please try different date'
							error!({ 'error_msg' => error_msg }, 401)
						end
					else
						error_msg = 'Enter correct date format'
						error!({ 'error_msg' => error_msg }, 401)
					end
			    end
		  desc 'Enter approriate month and year to find the expense'
		    params do
		      requires :month_year, type: String, desc: 'Enter Year and Month in format 2018-04'
		    end
		    post "/expense_by_month" do
				if params['month_year'].present?
					date = params['month_year'].split('-')
		  			year = date.first.to_i
		  			month = date.second.to_i
			  		@summary = @current_user.expenses.where(date: Date.new(year,month,1)..Date.new(year,month,-1))
			  		@total = @summary.sum(:amount)
		  			if @total.present?
						status 200
						present total: @total, list_by_month: @summary
					else
						error_msg = 'No Records were found,Please try different date'
						error!({ 'error_msg' => error_msg }, 401)
					end
				else
					error_msg = 'Enter correct month and year format'
					error!({ 'error_msg' => error_msg }, 401)
				end
		    end
	    desc 'Enter approriate year to find the expense'
		    params do
		      requires :year, type: String, desc: 'Enter Year in format 2018'
		    end
		    post "/expense_by_year" do
				if params['year'].present?
			  		date = params['year']
			  		year = date.to_i
			  		@summary = @current_user.expenses.where(date: Date.new(year,1,1)..Date.new(year,-1,-1))
			  		@total = @summary.sum(:amount)
		  			if @total.present?
						status 200
						present total: @total, list_by_year: @summary
					else
						error_msg = 'No Records were found,Please try different date'
						error!({ 'error_msg' => error_msg }, 401)
					end
				else
					error_msg = 'Enter correct year format'
					error!({ 'error_msg' => error_msg }, 401)
				end
		    end
			end
    	end
	end
end