# frozen_string_literal: true

require 'swagger_helper'

describe 'Categorias' do
  path '/api/v1/categories' do
    get 'Lista todas as categorias' do
      tags 'Categorias'
      produces 'application/json', 'application/xml'

      response '200', 'categorias cadastradas' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            description: { type: :string }
          }

        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/api/v1/categories' do
    post 'Cria uma categoria' do
      tags 'Categorias'
      consumes 'application/json'
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: [ 'description' ]
      }

      response '201', 'Categoria criada' do
        let(:category) { { description: 'Aluguel' } }

        run_test!
      end

      response '422', 'Request Invalida' do
        let(:category) { { } }

        run_test!
      end
    end
  end
  
  path '/api/v1/categories/{id}' do
    get 'Exibe detalhes de uma categoria' do
      tags 'Categorias'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'Categoria Encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            description: { type: :string },
          },
          required: [ 'id', 'description' ]

        let(:id) { FactoryBot.create(:category).id }
        run_test!
      end

      response '404', 'Categoria Nao Encontrada' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/categories/{id}' do
    put 'Atualiza a descrição de uma categoria' do
      tags 'Categorias'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: [ 'description' ]
      }

      response '200', 'Categoria Atualizada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            description: { type: :string },
          },
          required: [ 'id', 'description' ]

        let(:id) { FactoryBot.create(:category).id }
        run_test!
      end

      response '404', 'Categoria Nao Encontrada' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
