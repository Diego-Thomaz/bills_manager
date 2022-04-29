# frozen_string_literal: true

require 'swagger_helper'

describe 'Contas a Pagar' do
  path '/api/v1/accounts_payables' do
    get 'Lista todas as Contas a Pagar' do
      tags 'Contas a Pagar'
      produces 'application/json', 'application/xml'

      response '200', 'Contas a Pagar cadastradas' do
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

        before { FactoryBot.create(:accounts_payable) }
        run_test!
      end
    end
  end

  path '/api/v1/accounts_payables' do
    post 'Cria uma conta a pagar' do
      tags 'Contas a Pagar'
      consumes 'application/json'
      parameter name: :accounts_payable, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          amount: { type: :string },
          due_date: { type: :string },
          category_id: { type: :integer }
        }
      }

      response '201', 'Conta a pagar criada' do
        let(:accounts_payable) { FactoryBot.build(:accounts_payable) }

        run_test!
      end

      response '422', 'Request Invalida' do
        let(:accounts_payable) { { } }

        run_test!
      end
    end
  end
  
  path '/api/v1/accounts_payables/{id}' do
    get 'Exibe detalhes de uma conta a pagar' do
      tags 'Contas a Pagar'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'Conta a pagar encontrada' do
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

        let(:id) { FactoryBot.create(:accounts_payable).id }
        run_test!
      end

      response '404', 'Conta a pagar Nao Encontrada' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/accounts_payables/{id}' do
    put 'Atualiza a descrição de uma conta a pagar' do
      tags 'Contas a Pagar'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :accounts_payable, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          amount: { type: :string },
          due_date: { type: :string },
          category_id: { type: :integer }
        }
      }

      response '200', 'Conta a pagar atualizada' do
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

        let(:id) { FactoryBot.create(:accounts_payable).id }
        let(:accounts_payable) { { accounts_payable: { description: 'A new description' } } }
        run_test!
      end

      response '422', 'Conta a pagar nao atualizada' do
        let(:id) { FactoryBot.create(:accounts_payable).id }
        let(:accounts_payable) { { accounts_payable: { description: nil } } }

        run_test!
      end

      response '404', 'Conta a pagar Nao Encontrada' do
        let(:id) { 'invalid' }
        let(:accounts_payable) { { accounts_payable: { description: 'A new description' } } }

        run_test!
      end
    end
  end

  path '/api/v1/accounts_payables/{id}' do
    delete 'Exclui uma conta a pagar' do
      tags 'Contas a Pagar'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
  
      response '200', 'Conta a pagar atualizada' do
        let(:id) { FactoryBot.create(:accounts_payable).id }

        run_test!
      end

      response '404', 'Conta a pagar Nao Encontrada' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
