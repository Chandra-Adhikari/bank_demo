class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.float :amount
      t.string :transaction_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
