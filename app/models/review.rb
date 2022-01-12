class Review < ApplicationRecord
  belongs_to :user
  belongs_to :entity, polymorphic: true
  default_scope { order(created_at: :desc) }
end
