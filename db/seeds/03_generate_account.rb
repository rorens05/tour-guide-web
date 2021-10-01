gcash = Bank.create(
  name: "GCash",
  description: "GCash is a Philippine mobile wallet, mobile payments and branchless banking service. Introduced in 2004",
)

unionbank = Bank.create(
  name: "UnionBank",
  description: "The Union Bank of the Philippines, Inc., more commonly known as UnionBank, is one of the Universal Banks in the Philippines",
)

paymaya = Bank.create(
  name: "PayMaya",
  description: "PayMaya is an online payment account that has an app where you can load up in convenience stores, pawnshops, and mall and can purchase anything online.",
)

cimb = Bank.create(
  name: "CIMB Bank",
  description: "CIMB Bank Philippines Inc. is an entity regulated by the Bangko Sentral ng Pilipinas (Bangko Sentral).",
)

user = User.find_by(email: 'rorens05@gmail.com')

Account.create(
  bank: gcash,
  name: "Gcash",
  account_name: "Laurence Bautista",
  account_number: "09672854197",
  amount: 0,
  user: user
)

Account.create(
  bank: unionbank,
  name: "Unionbank Main",
  account_name: "Laurence Bautista",
  account_number: "109355127358",
  amount: 0,
  user: user
)

Account.create(
  bank: unionbank,
  name: "Unionbank Car Savings",
  account_name: "Laurence Bautista",
  account_number: "109355127358",
  amount: 0,
  user: user
)

Account.create(
  bank: unionbank,
  name: "Unionbank Business Savings",
  account_name: "Laurence Bautista",
  account_number: "109355127358",
  amount: 0,
  user: user
)

Account.create(
  bank: paymaya,
  name: "Paymaya",
  account_name: "Laurence Bautista",
  account_number: "09672854197",
  amount: 0,
  user: user
)

Account.create(
  bank: cimb,
  name: "CIMB",
  account_name: "Laurence Bautista",
  account_number: "09672854197",
  amount: 0,
  user: user
)

Category.create(
  name: "Default Income",
  description: "",
  transaction_type: "income",
)

Category.create(
  name: "Default Expense",
  description: "",
  transaction_type: "expense",
)