# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        render json: CategoryBlueprint.render(Category.all), status: :ok
      end

      def create
        new_category = Category.new(categories_params)

        if new_category.save
          render json: CategoryBlueprint.render(new_category), status: :created
        else
          render json: new_category.errors.full_messages, status: :unprocessable_entity
        end
      end

      def update
        if category.update(categories_params)
          render json: CategoryBlueprint.render(category), status: :ok
        else
          render json: category.errors.full_messages, status: :unprocessable_entity
        end
      end

      def show
        render json: CategoryBlueprint.render(category), status: :ok
      end

      private

      def categories_params
        params[:category].permit(:id, :description)
      end

      def category
        Category.find(params[:id])
      end
    end
  end
end
