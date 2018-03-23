module ApplicationHelper
	def account_number
		current_user.account.try(:account_number)
	end
	def user_balance
		current_user.try(:account).try(:balance)
	end

end