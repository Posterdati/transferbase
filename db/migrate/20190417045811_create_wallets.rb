class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.integer :currency_id, null: false
      t.integer :user_id, null: false
      t.decimal :total_amount_in_cents, null: false, default: 0
    end
  end
end
