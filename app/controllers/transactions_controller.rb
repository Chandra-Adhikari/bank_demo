require 'will_paginate/array'
class TransactionsController < ApplicationController
	before_action :authenticate_user!
	layout 'admin'
    include Transactions
	before_action :find_transaction, only: [:show]

	def index
		if (current_user.role == "user")
			@transactions = current_user.transactions.order('created_at DESC')
		else
			if params[:search].present?
				@transactions =  User.joins(:account).where(accounts: {account_number: params[:search]}).group(:id).map{|x| x.transactions}.flatten
	            @transactions = @transactions.sort_by{|e| [:created_at]}.reverse
			else
              @transactions = Transaction.all.order('created_at DESC')
            end
		end
		@transactions = @transactions.paginate(:page => params[:page])
		@transactions = Transaction.where(id: params[:transaction]).order("created_at desc").paginate(:page => params[:page], :per_page => 10) if params[:transaction].class.eql?(Array)
		respond_to do |format|
	        format.html
	        format.csv { send_data @transactions.to_csv }
	        format.xls { send_data @transactions.to_csv(col_sep: "\t") }
	    end
	end

	def new
		@transaction = current_user.transactions.build
	end

	def create
		type = params[:transaction][:transaction_type]
		case type
		when "Credit"
			@current_amount = current_user.account.balance + params[:transaction][:amount].to_f
			create_transaction(@current_amount)
		when "Debit"
			if (current_user.account.balance >= params[:transaction][:amount].to_f)
				@current_amount = current_user.account.balance - params[:transaction][:amount].to_f
				create_transaction(@current_amount)
			else
				flash[:error] = "You have insufficient balance."
				redirect_to new_transaction_path
			end
		end
	end

	def create_transaction(current_amount)
		@transaction = current_user.transactions.build(transaction_params)
		if @transaction.save
			update_balance(current_amount)
			UserMailer.transaction(@transaction).deliver_now
			redirect_to transactions_path, notice: 'Transaction created Successfully.'
		else
			flash[:error] = @transaction.errors.full_messages.first
			redirect_to new_transaction_path
		end
	end
	
	def show
	end

	private
	def find_transaction
		@transaction = Transaction.find_by(id: params[:id])
		redirect_to transactions_path unless @transaction
	end

	def transaction_params
		params.require(:transaction).permit(:transaction_id, :amount, :transaction_type, :user_id)
	end
end
