# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  belongs_to :currency
  has_many :wallets

  def transactions
    wallet_ids = wallets.pluck(:id)
    Transaction.where(receiver_id:wallet_ids).or(Transaction.where(sender_id: wallet_ids))
  end

  def wallet_by(currency_id)
    wallets.where(currency_id: currency_id).first
  end
end
