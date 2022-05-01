# frozen_string_literal: true

# FOR AccountsPayable and AccountsReceivable I could have used STI, but as I was creating this for a 
# workshop, I prefer to leave things as simple as possible.
class AccountsPayable < ApplicationRecord
  belongs_to :category

  validates :description, :due_date, :amount, presence: true

  scope :by_interval, ->(starts_on, ends_on) do
    where('accounts_payables.created_at BETWEEN :starts_on AND :ends_on', starts_on: starts_on, ends_on: ends_on)
  end
end
