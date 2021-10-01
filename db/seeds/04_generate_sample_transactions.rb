if Rails.env.development?
  User.all.each do |user|
    Account.all.each do |account|
      Category.all.each do |category|
        if category.transaction_type == "expense"
          rand(1..20).times.each do 
            time = rand(DateTime.now.beginning_of_month..DateTime.now.end_of_month)
            Transaction.create(
              account_id: account.id,
              category_id: category.id,
              amount: rand(1..100) * 10,
              note: "",
              schedule: time,
              status: 'completed',
              created_at: time,
              updated_at: time
            )
          end
        else
          rand(1..2).times.each do 
            time = rand(DateTime.now.beginning_of_month..DateTime.now.end_of_month)
            Transaction.create(
              account_id: account.id,
              category_id: category.id,
              amount: rand(1..30) * 1000,
              note: "",
              schedule: time,
              status: 'completed',
              created_at: time,
              updated_at: time
            )
          end
        end
      end
    end
  end
end