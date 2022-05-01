# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::GeneralReport, type: :service do
  subject { described_class.new(interval: interval).call }

  describe 'Given valid interval' do
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
    let(:accounts_receivable_1) { create(:accounts_receivable, category: category_1) }
    let(:accounts_receivable_2) { create(:accounts_receivable, category: category_2) }
    let(:accounts_receivable_3) { create(:accounts_receivable, category: category_2) }
    let!(:payable_total) { accounts_payable_1.amount + accounts_payable_2.amount + accounts_payable_3.amount }
    let!(:receivable_total) do
      accounts_receivable_1.amount + accounts_receivable_2.amount + accounts_receivable_3.amount
    end
    let(:expected_response) do
      {
        total_accounts_payable: {
          general: payable_total.to_d,
          by_category: {
            'Aluguel' => accounts_payable_1.amount.to_d,
            'Alimentacao' => accounts_payable_2.amount.to_d + accounts_payable_3.amount.to_d
          }
        },
        total_accounts_receivable: {
          general: receivable_total.to_d,
          by_category: {
            'Aluguel' => accounts_receivable_1.amount.to_d,
            'Alimentacao' => accounts_receivable_2.amount.to_d + accounts_receivable_3.amount.to_d
          }
        }
      }
    end
    
    it { is_expected.to eq expected_response }
  end

  describe 'Given invalid interval' do
    let(:interval) do
      { 
        starts_on: 'bla',
        ends_on: 1.month.from_now
      }
    end
    let(:error) do
      {
        error: 'Intervalo informado é inválido. As chaves aceitas no hash são: starts_on e ends_on, devem ' \
               'ser nulas ou datetime, e o ends_on deve ser maior que o starts_on'
      }
    end

    it { is_expected.to eq error }
  end
end
