# frozen_string_literal: true

module Dashboard
  module SummarizeAccounts
    class Receivable < Base
      def call
        {
          general: total_accounts_receivable,
          by_category: total_accounts_receivable_grouped_by_category
        }
      end

      private

      def total_accounts_receivable
        accounts_receivable_by_interval.sum(&:amount)
      end

      def total_accounts_receivable_grouped_by_category
        accounts_receivable_by_interval
          .joins(:category)
          .group('categories.description')
          .sum(:amount)
      end

      def accounts_receivable_by_interval
        AccountsReceivable.by_interval(starts_on, ends_on)
      end
    end
  end
end
