class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.belongs_to :household, foreign_key: true
      t.datetime :date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
