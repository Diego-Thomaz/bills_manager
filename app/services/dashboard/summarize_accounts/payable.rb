# frozen_string_literal: true

module Dashboard
  module SummarizeAccounts
    class Payable < Base
      def call
        {
          general: total_accounts_payable,
          by_category: total_accounts_payable_grouped_by_category
        }
      end

      private

      def total_accounts_payable
        accounts_payable_by_interval.sum(&:amount)
      end

      def total_accounts_payable_grouped_by_category
        accounts_payable_by_interval
          .joins(:category)
          .group('categories.description')
          .sum(:amount)
      end

      def accounts_payable_by_interval
        AccountsPayable.by_interval(starts_on, ends_on)
      end
    end
  end
end
