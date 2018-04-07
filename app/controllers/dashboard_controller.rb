class DashboardController < ApplicationController
  def index
  end

  def summary
  		if request.post?
	  		date = Date.new(params['date(1i)'].to_i,params['date(2i)'].to_i,params['date(3i)'].to_i )
	  		date = date.to_s
	  		@summary = Expense.where(date: date)
	  		@total = @summary.sum(:amount).to_i
  		end
  end

end
