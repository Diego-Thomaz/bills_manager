# frozen_string_literal: true

class AccountsReceivable < ApplicationRecord
  belongs_to :category

  validates :due_date, :description, :amount, presence: true
end
