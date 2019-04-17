class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.decimal :excange_rate_in_cents, null: false
      t.decimal :amount_in_cents, null: false
      t.timestamps null: false
    end

    add_index :transactions, :sender_id
    add_index :transactions, :receiver_id
  end
end
