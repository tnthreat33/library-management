class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :transaction_type
      t.date :transaction_date
      t.date :due_date

      t.timestamps
    end
  end
end
