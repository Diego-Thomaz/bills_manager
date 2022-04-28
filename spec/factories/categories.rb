# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    description { FFaker::LoremBR.word }
  end
end
