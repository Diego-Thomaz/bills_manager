# frozen_string_literal: true

class AccountsReceivableBlueprint < Blueprinter::Base
  identifier :id

  fields :description, :amount, :due_date

  view :normal do
    association :category, blueprint: CategoryBlueprint
  end
end
