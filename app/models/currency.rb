class Currency < ApplicationRecord
  has_many :wallets

  def excange_rates_in_cents
    case code
    when 'EUR'
      { EUR: 100, USD: 113, GBP: 87 }
    when 'GBP'
      { EUR: 115, USD: 131, GBP: 100 }
    else
      { EUR: 88, GBP: 77, USD: 100 }
    end
  end
end
