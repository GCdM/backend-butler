class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :display_name
      t.string :password_digest
      t.string :img_url
      t.belongs_to :household, foreign_key: true

      t.timestamps
    end
  end
end
