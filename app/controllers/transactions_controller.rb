# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:wallet_id]
      @transactions = current_user.transactions.where(sender_id: params[:wallet_id]).or(Transaction.where(receiver_id: params[:wallet_id]))
    else
      @transactions = current_user.transactions
    end

    @wallets = current_user.wallets.order(:id)
  end

  def new
    @users = User.where.not(id: current_user.id)
    @currencies = Currency.all
  end

  def create
    sender_wallet = current_user.wallet_by(transaction_params[:source_currency])
    amount = transaction_params[:amount][:total].to_i * 100

    if amount > sender_wallet.total_amount_in_cents
      flash[:warning] = 'You don\'t have funds for this transfer!'
      redirect_to new_transaction_path and return
    end

    receiver_user = User.find_by!(id: transaction_params[:receiver])

    Transaction.create_transaction!(
      sender_wallet,
      receiver_user.wallet_by(transaction_params[:target_currency]),
      amount
    )
    flash[:success] = 'Transaction executed!'
    redirect_to new_transaction_path and return
  end

  private

  def transaction_params
   params.permit(
     :receiver,
     :source_currency,
     :target_currency,
     amount: [:total]
   )
  end
end
