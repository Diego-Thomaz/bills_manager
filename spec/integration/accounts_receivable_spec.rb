# frozen_string_literal: true

require 'swagger_helper'

describe 'Contas a Receber' do
  path '/api/v1/accounts_receivables' do
    get 'Lista todas as Contas a Receber' do
      tags 'Contas a receber'
      produces 'application/json', 'application/xml'

      response '200', 'Contas a receber cadastradas' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              amount: { type: :string },
              category: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  description: { type: :string }
                }
              },
              description: { type: :string },
              due_date: { type: :string }
            }
          }

        before { FactoryBot.create(:accounts_receivable) }
        run_test!
      end
    end
  end

  path '/api/v1/accounts_receivables' do
    post 'Cria uma conta a receber' do
      tags 'Contas a Receber'
      consumes 'application/json'
      parameter name: :accounts_receivable, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          amount: { type: :string },
          due_date: { type: :string },
          category_id: { type: :integer }
        }
      }

      response '201', 'Conta a receber criada com sucesso' do
        let(:accounts_receivable) { FactoryBot.build(:accounts_receivable) }

        run_test!
      end

      response '422', 'Request Invalida' do
        let(:accounts_receivable) { { } }

        run_test!
      end
    end
  end

  path '/api/v1/accounts_receivables/{id}' do
    get 'Exibe detalhes de uma conta a receber' do
      tags 'Contas a receber'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'Conta a receber encontrada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            amount: { type: :string },
            category: {
              type: :object,
              properties: {
                id: { type: :integer },
                description: { type: :string }
              }
            },
            description: { type: :string },
            due_date: { type: :string }
          }

        let(:id) { FactoryBot.create(:accounts_receivable).id }
        run_test!
      end

      response '404', 'Conta a receber Nao Encontrada' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/accounts_receivables/{id}' do
    put 'Atualiza a descrição de uma conta a receber' do
      tags 'Contas a receber'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :accounts_receivable, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          amount: { type: :string },
          due_date: { type: :string },
          category_id: { type: :integer }
        }
      }

      response '200', 'Conta a receber atualizada' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            amount: { type: :string },
            category: {
              type: :object,
              properties: {
                id: { type: :integer },
                description: { type: :string }
              }
            },
            description: { type: :string },
            due_date: { type: :string }
          }

        let(:id) { FactoryBot.create(:accounts_receivable).id }
        let(:accounts_receivable) { { accounts_receivable: { description: 'Another description' } } }
        run_test!
      end

      response '422', 'Conta a receber nao atualizada' do
        let(:id) { FactoryBot.create(:accounts_receivable).id }
        let(:accounts_receivable) { { accounts_receivable: { description: nil } } }

        run_test!
      end

      response '404', 'Conta a receber Nao Encontrada' do
        let(:id) { 'invalid' }
        let(:accounts_receivable) { { accounts_receivable: { description: 'A new description' } } }

        run_test!
      end
    end
  end

  path '/api/v1/accounts_receivables/{id}' do
    delete 'Exclui uma conta a receber' do
      tags 'Contas a receber'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
  
      response '200', 'Conta a receber atualizada' do
        let(:id) { FactoryBot.create(:accounts_receivable).id }

        run_test!
      end

      response '404', 'Conta a receber Nao Encontrada' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
