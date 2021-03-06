# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#validations' do
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:description) }
  end
end
