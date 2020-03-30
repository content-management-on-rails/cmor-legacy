module Cmor::MultiTenancy
  class Client < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }, length: { minimum: 3, maximum: 63 }
    validates :title, presence: true, uniqueness: true
    validates :active_from, presence: true
    validates :active_to, presence: true
  end
end
