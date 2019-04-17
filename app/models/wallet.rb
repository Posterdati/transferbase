# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :currency
  belongs_to :user

  def total_amount
    total_amount_in_cents / 100
  end
end
