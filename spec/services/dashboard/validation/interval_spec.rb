# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::Validation::Interval, type: :service do
  subject { described_class.new(interval).valid? }

  describe 'Given valid intervals' do
    let(:interval) do
      { 
        starts_on: Time.zone.now.beginning_of_month,
        ends_on: 1.month.from_now
      }
    end

    it { is_expected.to be_truthy }
  end

  describe 'Given invalid intervals' do
    context 'when ends_on is smaller then starts_on' do
      let(:interval) do
        { 
          starts_on: Time.zone.now.beginning_of_month,
          ends_on: 1.month.ago
        }
      end

      it { is_expected.to be_falsy }
    end

    context 'when either ends_on or starts_on is missing' do
      let(:interval) do
        { 
          ends_on: 1.month.ago
        }
      end

      it { is_expected.to be_falsy }
    end

    context 'when starts_on is not a datetime' do
      let(:interval) do
        { 
          starts_on: 'bla',
          ends_on: 1.month.ago
        }
      end

      it { is_expected.to be_falsy }
    end

    context 'when ends_on is not a datetime' do
      let(:interval) do
        { 
          starts_on: Time.zone.now,
          ends_on: 'bla'
        }
      end

      it { is_expected.to be_falsy }
    end
  end
end
