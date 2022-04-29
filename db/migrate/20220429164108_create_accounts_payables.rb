class CreateAccountsPayables < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts_payables do |t|
      t.money :amount
      t.date :due_date
      t.string :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
