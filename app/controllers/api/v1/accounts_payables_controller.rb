# frozen_string_literal: true

module Api
  module V1
    class AccountsPayablesController < ApplicationController
      def index
        render json: AccountsPayableBlueprint.render(AccountsPayable.all, view: :normal), status: :ok
      end

      def create
        new_accounts_payable = AccountsPayable.new(accounts_payable_params)

        if new_accounts_payable.save
          render json: AccountsPayableBlueprint.render(new_accounts_payable, view: :normal), status: :created
        else
          render json: new_accounts_payable.errors.full_messages, status: :unprocessable_entity
        end
      end

      def update
        if accounts_payable.update(accounts_payable_params)
          render json: AccountsPayableBlueprint.render(accounts_payable, view: :normal), status: :ok
        else
          render json: accounts_payable.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        accounts_payable.destroy
        render json: { message: 'Conta excluída com sucesso' }, status: :ok
      end

      def show
        render json: AccountsPayableBlueprint.render(accounts_payable, view: :normal), status: :ok
      end

      private

      def accounts_payable_params
        params[:accounts_payable].permit(:amount, :description, :due_date, :category_id, :id)
      end

      def accounts_payable
        accounts_payable = AccountsPayable.find(params[:id])
      end
    end
  end
end
