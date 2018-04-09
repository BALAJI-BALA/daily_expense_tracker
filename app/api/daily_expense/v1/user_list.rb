module DailyExpense
  	module V1
	    class UserList < Grape::API
	    version 'v1', using: :path
      	format :json
 		 prefix :api
	      desc 'Login via email and password'
	      	resource :user_authentication do
			    params do
			      requires :email, type: String, desc: 'email'
			      requires :password, type: String, desc: 'password'
			    end
			    post "/login"do
			    	user = User.find_by(email: params[:email].downcase)
					  if user.present? && user.valid_password?(params[:password])
					  	 user.regenerate_auth_token
					 #  	token = user.authentication_tokens.valid.first || AuthenticationToken.generate(user)
  						 status 200
						 present email: user.email, token: user.auth_token
					  else
					    error_msg = 'Bad Authentication Parameters'
					    error!({ 'error_msg' => error_msg }, 401)
					  end
			    end
			    params do
			      requires :email, type: String, desc: 'email'
			      requires :password, type: String, desc: 'password'
			      requires :password_confirmation, type: String, desc: 'password'
			    end
		    desc 'Sign Up via email and password'
			    post "/sign_up"do
			    	if user = User.find_by(email: params[:email].downcase)
			    		error_msg = 'Email already taken please try different one'
						error!({ 'error_msg' => error_msg }, 401)
					else
				    	user = User.new(email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation])
				    	if params[:password] == params[:password_confirmation]
						  if user.save! 
	  						status 200
							present email: user.email, token: user.auth_token
						  else
						    error_msg = 'Something went wrong please try again'
						    error!({ 'error_msg' => error_msg }, 401)
						  end
						else
							error_msg = 'password and password_confirmation mismatching please try again'
						    error!({ 'error_msg' => error_msg }, 401)
						end
					end
			    end
			desc 'Get Users list'
				before do
   		 			authenticate!
  				end
				get do
					user_list = User.all
						puts params[:api_key]
					if user_list.present?
						status 200
						present user_list, with: DailyExpense::Entities::User
					else
						status 400
						present failure: "No category was found please create a new one"
					end
				end
			end
	    end 
	end
end
