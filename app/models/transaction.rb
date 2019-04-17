class Transaction < ApplicationRecord
  include ActiveModel::Model

  belongs_to :sender, class_name: 'Wallet'
  belongs_to :receiver, class_name: 'Wallet'

  def amount
    amount_in_cents / 100
  end

  def amount_in_target_currency
    (amount_in_cents * excange_rate_in_cents) / 10000 
  end

  def excange_rate
    excange_rate_in_cents / 100
  end

  def self.create_transaction!(sender, receiver, amount_in_cents)
    Transaction.transaction do
      receiver_currency_code = receiver.currency.code.to_sym
      transaction = Transaction.new
      transaction.receiver_id = receiver.id
      transaction.sender_id = sender.id
      transaction.excange_rate_in_cents = sender.currency.excange_rates_in_cents[receiver_currency_code]
      transaction.amount_in_cents = amount_in_cents
      transaction.save!

      sender.total_amount_in_cents -= amount_in_cents
      sender.save!

      receiver.total_amount_in_cents += (amount_in_cents * transaction.excange_rate_in_cents) / 100
      receiver.save!
    end
  end
end
