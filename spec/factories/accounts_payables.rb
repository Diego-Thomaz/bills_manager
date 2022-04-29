# frozen_string_literal: true

FactoryBot.define do
  factory :accounts_payable do
    amount { rand(100..1000) }
    due_date { Time.zone.today }
    description { FFaker::Product.product_name }
    category { create(:category) }
  end
end
