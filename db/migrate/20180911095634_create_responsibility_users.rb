class CreateResponsibilityUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibility_users do |t|
      t.belongs_to :responsibility, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
