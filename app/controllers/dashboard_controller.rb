class DashboardController < ApplicationController
	def index

	end

	def summary
			if request.post?
				if params['year'].present?
			  		date = params['year']
			  		year = date.to_i
			  		@summary = current_user.expenses.where(date: Date.new(year,1,1)..Date.new(year,-1,-1))
			  		puts "========"
			  		puts @summary.inspect
			  		puts "========"
			  		@total = @summary.sum(:amount).round(2)
	  			elsif params['month_year'].present?
		  			date = params['month_year'].split('-')
		  			year = date.first.to_i
		  			month = date.second.to_i
			  		@summary = current_user.expenses.where(date: Date.new(year,month,1)..Date.new(year,month,-1))
			  		@total = @summary.sum(:amount).round(2)
			  	elsif params['date_month_year'].present?
			  		date = Date.parse(params['date_month_year'])
			  		date = date.to_s
			  		@summary = current_user.expenses.where(date: date)
			  		@total = @summary.sum(:amount).round(2)
	  			end
			end
	end

end
