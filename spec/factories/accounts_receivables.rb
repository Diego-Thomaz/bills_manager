FactoryBot.define do
  factory :accounts_receivable do
    amount { rand(100..1000) }
    due_date { Time.zone.today }
    description { FFaker::Product.product_name }
    category { create(:category) }
  end
end
