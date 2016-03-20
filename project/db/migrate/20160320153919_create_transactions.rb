class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :product_req_id
      t.integer :product_offert_id
      t.string :status

      t.timestamps
    end
  end
end
