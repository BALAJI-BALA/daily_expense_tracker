json.extract! expense, :id, :date, :item, :method, :amount, :user_id, :category_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
