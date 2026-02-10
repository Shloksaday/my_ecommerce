class AddAmountToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :amount, :integer
  end
end
