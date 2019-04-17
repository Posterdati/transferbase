# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Currency.destroy_all

usd = Currency.create!(full_name: 'Dollar', code: 'USD')
eur = Currency.create!(full_name: 'Euro', code: 'EUR')
gbp = Currency.create!(full_name: 'Pound', code: 'GBP')

(1..5).each { |i| User.create!(email: "user#{i}@test.com", password: 'password', password_confirmation: 'password', currency_id: usd.id) }

def create_wallets(user)
  Currency.all.each do |currency|
    Wallet.create!(
      currency_id: currency.id,
      user_id: user.id,
      total_amount_in_cents: currency.code == 'USD' ? 100000 : 0
    )
  end
end

User.all.each{|user| create_wallets(user) }
