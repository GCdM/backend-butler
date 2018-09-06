class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :date
      t.monetize :amount
      t.string :category

      t.timestamps
    end
  end
end
