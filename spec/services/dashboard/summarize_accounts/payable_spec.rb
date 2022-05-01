# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::SummarizeAccounts::Payable, type: :service do
  subject { described_class.new(interval).call }

  let(:interval) do
    { 
      starts_on: Time.zone.now.beginning_of_month,
      ends_on: 1.month.from_now
    }
  end
  let(:category_1) { create(:category, description: 'Aluguel') }
  let(:category_2) { create(:category, description: 'Alimentacao') }
  let(:accounts_payable_1) { create(:accounts_payable, category: category_1) }
  let(:accounts_payable_2) { create(:accounts_payable, category: category_2) }
  let(:accounts_payable_3) { create(:accounts_payable, category: category_2) }
  let!(:total_amount) { accounts_payable_1.amount + accounts_payable_2.amount + accounts_payable_3.amount }
  let(:total_amount_by_category) do
    {
      'Aluguel' => accounts_payable_1.amount.to_d,
      'Alimentacao' => accounts_payable_2.amount.to_d + accounts_payable_3.amount.to_d
    }
  end
  let(:expected_response) do
    {
      general: total_amount.to_d,
      by_category: total_amount_by_category
    }
  end

  it { is_expected.to eq expected_response }
end
