class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token
      t.datetime :date
      t.integer :id_user

      t.timestamps
    end
  end
end
