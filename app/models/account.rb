class Account < ApplicationRecord
  belongs_to :user
  belongs_to :bank

  has_many :transactions, dependent: :destroy

  def label_name
    "#{user.name} - #{name}"
  end

  def update_amount
    self.amount = transactions.incomes.completed.sum(:amount) - transactions.expenses.completed.sum(:amount)
    self.save
  end
end
