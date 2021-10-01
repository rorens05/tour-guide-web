class Transaction < ApplicationRecord
  has_one_attached :image
  belongs_to :account
  belongs_to :category
  enum status: ["completed", "pending"]
  validates :status, presence: true
  validates :amount, presence: true

  after_save :update_account_amount

  before_save :update_schedule

  scope :expenses, -> { joins(:category).where(categories: {transaction_type: 'expense'}) }
  scope :incomes, -> { joins(:category).where(categories: {transaction_type: 'income'}) }
  scope :between_dates, ->(start_date, end_date){ where(schedule: start_date.beginning_of_day..end_date.end_of_day) }

  def update_account_amount
    account.update_amount
  end

  def update_schedule
    if schedule.blank?
      schedule = DateTime.now
    end
  end
end
