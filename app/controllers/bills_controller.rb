class BillsController < ApplicationController
	get '/bills' do
		if session[:user_id]
	        @user = User.find(session[:user_id])
	        @bills = @user.bills
			erb :"/bills/bills"
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

	patch '/bills/:id' do
		if session[:user_id] and !params[:company_name].empty? and !params[:due_date].empty?
			@bill = Bill.find(params[:id])
			@bill.update(company_name: params[:company_name], amount: params[:amount], due_date: params[:due_date], recurrence: params[:recurrence], paid: params[:paid])
			redirect "/bills"
		else
			"fill in all."
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

#bill = Bill.new(company_name: "Coned", amount: 100.50, due_date: "Nov20_2020", paid: false, user_id: 1)