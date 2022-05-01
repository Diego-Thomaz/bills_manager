# frozen_string_literal: true

module Dashboard
  module SummarizeAccounts
    class Base
      DEFAULT_INTERVAL = {
        starts_on: Time.zone.now.beginning_of_month,
        ends_on: Time.zone.now.end_of_month
      }

      def initialize(interval)
        @interval = interval
      end

      private

      attr_reader :interval

      def starts_on
        interval[:starts_on].present? ? interval[:starts_on] : DEFAULT_INTERVAL[:starts_on]
      end

      def ends_on
        interval[:ends_on].present? ? interval[:ends_on] : DEFAULT_INTERVAL[:ends_on]
      end
    end
  end
end
