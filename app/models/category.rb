class Category < ApplicationRecord
  enum transaction_type: ["income", "expense"]
end
