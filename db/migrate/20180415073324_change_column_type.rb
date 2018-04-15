class ChangeColumnType < ActiveRecord::Migration[5.1]
  def change
  	change_column :expenses, :amount, 'numeric USING amount::numeric(8,2)'
  end
end
