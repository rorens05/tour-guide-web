class City < ActiveRecord::Base

  belongs_to :province
  default_scope { order(name: :asc) }

end
