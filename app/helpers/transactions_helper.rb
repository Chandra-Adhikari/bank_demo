module TransactionsHelper

	def transaction_id transaction
		transaction.try(:transaction_id)
	end

	def transaction_date transaction
		transaction.try(:created_at)
	end

	def amount transaction
		transaction.try(:amount)
	end

	def transaction_type transaction
		transaction.try(:transaction_type)
	end

	def user transaction
		transaction.try(:user).try(:name)
	end
end
