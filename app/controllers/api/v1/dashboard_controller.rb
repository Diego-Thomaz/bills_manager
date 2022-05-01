# frozen_string_literal: true

module Api
  module V1
    class DashboardController < ApplicationController
      def index
        response = Dashboard::GeneralReport.new(interval: interval).call
        render json: response.to_json, status: response[:error].nil? ? :ok : :unprocessable_entity
      end

      private

      def interval
        {
          starts_on: params[:starts_on],
          ends_on: params[:ends_on]
        }
      end
    end
  end
end
