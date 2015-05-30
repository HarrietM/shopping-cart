class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.string :current
      # t.references :ordered_product
      t.timestamps null: false
    end
  end
end
