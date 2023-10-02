class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :num
      t.string :name
      t.string :tel
      t.string :status
      t.string :solution
      t.integer :amount
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :orders, :num, unique: true
  end
end
