# frozen_string_literal: true

module Api
  module V1
    class AccountsReceivablesController < ApplicationController
      def index
        render json: AccountsReceivableBlueprint.render(AccountsReceivable.all, view: :normal), status: :ok
      end

      def create
        new_accounts_receivable = AccountsReceivable.new(accounts_receivable_params)

        if new_accounts_receivable.save
          render json: AccountsReceivableBlueprint.render(new_accounts_receivable), status: :created
        else
          render json: { error: new_accounts_receivable.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if accounts_receivable.update(accounts_receivable_params)
          render json: AccountsReceivableBlueprint.render(accounts_receivable), status: :ok
        else
          render json: { error: accounts_receivable.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        accounts_receivable.destroy
        render json: { message: 'Conta a Receber excluída com sucesso' }, status: :ok
      end

      def show
        render json: AccountsReceivableBlueprint.render(accounts_receivable, view: :normal), status: :ok
      end

      private

      def accounts_receivable_params
        params[:accounts_receivable].permit(:amount, :due_date, :description, :category_id)
      end

      def accounts_receivable
        AccountsReceivable.find(params[:id])
      end
    end
  end
end
