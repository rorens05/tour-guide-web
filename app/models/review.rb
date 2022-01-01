class Review < ApplicationRecord
  belongs_to :user
  belongs_to :entity, polymorphic: true
end
