# frozen_string_literal: true

require 'swagger_helper'

describe 'Dashboard' do
  path '/api/v1/dashboard' do
    get 'Dashboard data' do
      tags 'Dashboard'
      produces 'application/json'
      parameter name: :starts_on, in: :query, type: :string
      parameter name: :ends_on, in: :query, type: :string

      response '200', 'dashboard' do
        schema type: :object,
          properties: {
            total_accounts_payable: {
              type: :object,
              properties: {
                general: { type: :string },
                by_category: { type: :object }
              }
            },
            total_accounts_receivable: {
              type: :object,
              properties: {
                general: { type: :string },
                by_category: { type: :object }
              }
            }
          }

        let(:category_1) { create(:category, description: 'Aluguel') }
        let!(:accounts_payable_1) { create(:accounts_payable, category: category_1) }
        let!(:accounts_receivable_1) { create(:accounts_receivable, category: category_1) }
        let(:starts_on) { Time.zone.now.beginning_of_month }
        let(:ends_on) { 1.month.from_now }

        run_test!
      end
    end
  end
end
