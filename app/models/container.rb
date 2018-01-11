class Container < ApplicationRecord
  validates :number, :size, :type, presence: true
end
