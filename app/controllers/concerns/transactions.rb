module Transactions
 extend ActiveSupport::Concern

  def update_balance(current_amount)
  	current_user.account.update_attributes(balance: current_amount)
  end
end