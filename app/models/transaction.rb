require 'csv'
class Transaction < ApplicationRecord
  belongs_to :user
  before_create :generate_id
  
  self.per_page = 10
  
  def generate_id
	begin
	self.transaction_id = SecureRandom.hex
	end while Transaction.where(transaction_id: transaction_id).exists?
  end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |transaction|
          csv << transaction.attributes.values
        end
      end
    end
end
