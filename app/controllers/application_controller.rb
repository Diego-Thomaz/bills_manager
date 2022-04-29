# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  private

  def show_errors(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
