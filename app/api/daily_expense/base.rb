module DailyExpense
	class Base < Grape::API
		helpers do
			def authenticate!
	     		 error!('Unauthorized. Invalid or expired token. Please login to generate new Token', 401) unless current_user
	    	end

    		def current_user
      			# find token. Check if valid.
      			if params[:api_key].present? 
	      			token = User.where(auth_token: params[:api_key]).first
				     expired = DateTime.now.utc >= token.token_expires_at
					if token.present? && !expired
						@current_user = User.find(token.id)
					else
						false
					end
				else
					false
				end
    		end
	    end
		mount DailyExpense::V1::ExpenseList
		mount DailyExpense::V1::CategoryList	
		mount DailyExpense::V1::UserList
		mount DailyExpense::V1::Summary

		add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
	end
end