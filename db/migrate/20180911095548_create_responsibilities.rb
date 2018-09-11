class CreateResponsibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :responsibilities do |t|
      t.belongs_to :household, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
