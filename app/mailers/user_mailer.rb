class UserMailer < ApplicationMailer
	
	def transaction(transaction)
		@email = transaction.user.email
		@name = transaction.user.name
		@balance = transaction.user.account.balance
		@transaction = transaction
		@user = transaction.user
		mail(to: @email, subject: 'Transaction Confirmation')
	end	
end
