require 'rails_helper'

RSpec.describe AccountsReceivable, type: :model do
  describe '#associations' do
    it { should belong_to(:category) }
  end
end
