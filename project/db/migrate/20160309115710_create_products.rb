class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :idProduct
      t.string :name
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
