class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :expense, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.monetize :amount
      t.boolean :paid
      t.boolean :received

      t.timestamps
    end
  end
end
