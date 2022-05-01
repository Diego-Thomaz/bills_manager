require 'rails_helper'

RSpec.describe AccountsReceivable, type: :model do
  describe '#associations' do
    it { should belong_to(:category) }
  end

  describe '#validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:due_date) }
    it { should validate_presence_of(:amount) }
  end

  describe '#scopes' do
    context 'by_interval' do
      subject(:by_interval) { described_class.by_interval(starts_on, ends_on) }
      let(:starts_on) { Time.zone.now.beginning_of_month }
      let(:ends_on) { 1.month.from_now }
      let(:old_account_payable) { create(:accounts_receivable, created_at: 1.month.ago) }
      let(:new_account_payables) { create_list(:accounts_receivable, 3) }

      before do
        old_account_payable
        new_account_payables
      end

      it { expect(by_interval).to match_array(new_account_payables) }
      it { expect(by_interval).not_to include(old_account_payable) }
    end
  end
end
