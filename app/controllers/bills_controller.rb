class BillsController < ApplicationController
	get '/bills' do
		if session[:user_id]
	        @user = User.find(session[:user_id])
	        @bills = @user.bills
			erb :"/bills/bills"
		else
			redirect "login"
		end
	end

	get '/bills/:id/edit' do
		if se
		@bill = Bill.find(params[:id])
		erb :"/bills/edit"
	end

end

#bill = Bill.new(company_name: "Coned", amount: 100.50, due_date: "Nov20_2020", paid: false, user_id: 1)