# frozen_string_literal: true

class Category < ApplicationRecord
  validates :description, presence: true
  validates :description, uniqueness: true
end
