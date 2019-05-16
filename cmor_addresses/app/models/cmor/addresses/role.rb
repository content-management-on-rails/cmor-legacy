module Cmor::Addresses
  class Role < ApplicationRecord
    has_many :addresses, dependent: :destroy

    validates :identifier, presence: true, uniqueness: true
    validates :name, presence: true, uniqueness: true
  end
end
