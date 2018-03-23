class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :account_number, default: ""
      t.string :ipin, default: ""
      t.string :ipin, default: ""
      t.float :balance, default: 0.00
      t.references :user, index: true
      
      t.timestamps
    end
  end
end
