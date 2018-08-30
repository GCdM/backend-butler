class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :date
      t.float :amount
      t.string :type

      t.timestamps
    end
  end
end
