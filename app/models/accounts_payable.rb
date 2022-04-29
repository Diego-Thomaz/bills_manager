# frozen_string_literal: true

class AccountsPayable < ApplicationRecord
  belongs_to :category

  validates :description, :due_date, :amount, presence: true
end
