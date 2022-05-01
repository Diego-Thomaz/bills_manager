# frozen_string_literal: true

module Dashboard
  module Validation
    class Interval
      VALID_KEYS = %w[starts_on ends_on]

      def initialize(interval)
        @interval = interval
      end

      def valid?
        return false unless valid_keys?
        return false unless values_are_nil_or_datetime?
        return false unless ends_on_is_greater_than_starts_on?

        true
      end

      private

      attr_reader :interval

      def valid_keys?
        (VALID_KEYS - interval.stringify_keys.keys).empty?
      end

      def values_are_nil_or_datetime?
        valid_starts_on? && valid_ends_on?
      end

      def valid_starts_on?
        interval[:starts_on].nil? || interval[:starts_on].to_datetime
      rescue Date::Error
        false
      end

      def valid_ends_on?
        interval[:ends_on].nil? || interval[:ends_on].to_datetime
      rescue Date::Error
        false
      end

      def ends_on_is_greater_than_starts_on?
        return true if interval[:starts_on].nil? || interval[:ends_on].nil?

        interval[:ends_on].to_datetime > interval[:starts_on].to_datetime
      end
    end
  end
end
