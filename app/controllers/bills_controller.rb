class BillsController < ApplicationController
	get '/bills' do
		if session[:user_id]
	        @user = User.find(session[:user_id])
	        @bills = @user.bills
	        if @bills.empty?
	        	redirect '/bills/new'
	        else
				erb :"/bills/bills"
			end
		else
			redirect "/login"
		end
	end

	post '/bills' do
		if session[:user_id]
	        @user = User.find(session[:user_id])
	        if !params.values.any? ("")
	        	@user.bills << Bill.create(company_name: params[:company_name], amount: params[:amount], due_date: params[:due_date], recurrence: params[:recurrence], paid: params[:paid])
	        	redirect '/bills'
	        else
	        	"please enter all fields"
	        end
	    else
			redirect "/login"
		end
	end

	get '/bills/new' do
		if session[:user_id]
	        @user = User.find(session[:user_id])
			erb :"/bills/new"
		else
			redirect "/login"
		end
	end

	get '/bills/:id/edit' do
		if session[:user_id]
			@bill = Bill.find(params[:id])
			erb :"/bills/edit_bill"
		else
			redirect "/login"
		end
	end

end

#bill = Bill.new(company_name: "Coned", amount: 100.50, due_date: "Nov20_2020", paid: false, user_id: 1)