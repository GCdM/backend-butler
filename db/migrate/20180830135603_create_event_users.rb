class CreateEventUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :event_users do |t|
      t.belongs_to :event, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
