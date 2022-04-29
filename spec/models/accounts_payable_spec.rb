# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountsPayable, type: :model do
  describe '#associations' do
    it { should belong_to(:category) }
  end

  describe '#validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:due_date) }
    it { should validate_presence_of(:amount) }
  end
end
