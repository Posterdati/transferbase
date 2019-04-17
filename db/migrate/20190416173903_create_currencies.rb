class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :code, null: false
      t.string :full_name, null: false
      t.timestamps null: false
    end
  end
end
