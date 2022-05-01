# frozen_string_literal: true

module Dashboard
  class GeneralReport
    def initialize(interval: {})
      @interval = interval
    end

    def call
      return interval_error unless valid_interval?

      summarize_accounts
    end

    private

    attr_reader :interval

    def valid_interval?
      Dashboard::Validation::Interval.new(interval).valid?
    end

    # Generic error for workshop purposes only
    def interval_error
      {
        error: 'Intervalo informado é inválido. As chaves aceitas no hash são: starts_on e ends_on, devem ' \
                'ser nulas ou datetime, e o ends_on deve ser maior que o starts_on'
      }
    end

    def summarize_accounts
      {
        total_accounts_payable: SummarizeAccounts::Payable.new(interval).call,
        total_accounts_receivable: SummarizeAccounts::Receivable.new(interval).call
      }
    end
  end
end
