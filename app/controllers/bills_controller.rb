class BillsController < ApplicationController
	get '/bills' do
		if session[:user_id]
	        @user = User.find(session[:user_id])
	        @bills = @user.bills
	        @non_recurring = @user.bill_categories("no")
        	@monthly_bills = @user.bill_categories("monthly")
        	@quarterly_bills = @user.bill_categories("quarterly")
        	@yearly_bills = @user.bill_categories("yearly")

			erb :"/bills/bills"
		else
			redirect "/login"
		end
	end

	post '/bills' do
		if session[:user_id] and @user = User.find(session[:user_id]) and !params.values.any? ("")
        	@user.bills << Bill.create(company_name: params[:company_name], amount: params[:amount], due_date: params[:due_date], recurrence: params[:recurrence], paid: params[:paid])
        	redirect '/bills'
	    else
			redirect "/login"
		end
	end

	get '/bills/new' do
		if current_user
	        @user = User.find(session[:user_id])
			erb :"/bills/new"
		else
			redirect "/login"
		end
	end

	get '/bills/:id/edit' do
		@bill = Bill.find(params[:id])

		if @bill.user_id == current_user.id
			erb :"/bills/edit_bill"
		else
			redirect "/login"
		end
	end

	patch '/bills/:id' do
		if session[:user_id] and !params.include? ("company_name")
			@bill = Bill.find(params[:id])
			@bill.update(paid: params[:paid])
			redirect '/bills'
		elsif session[:user_id] and params.include? ("company_name")
			@bill = Bill.find(params[:id])
			@bill.update(company_name: params[:company_name], amount: params[:amount], due_date: params[:due_date], recurrence: params[:recurrence], paid: params[:paid])
			redirect "/bills"
		else
			redirect "/login"
		end
	end

	delete '/bills/:id' do
		if session[:user_id]
			@bill = Bill.find(params[:id])
			@bill.delete
			redirect to '/bills'
		else
			redirect '/login'
		end
	end

end