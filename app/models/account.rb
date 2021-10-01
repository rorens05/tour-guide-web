class Account < ApplicationRecord
  belongs_to :user
  belongs_to :bank

  def label_name
    "#{user.name} - #{name}"
  end

end
