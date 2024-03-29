class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.string :details
      t.integer :process_status
      t.boolean :deleted, default: false

      t.references :sending_user, null: false
      t.references :receiving_user, null: true

      t.references :sended_book, null: false

      t.timestamps
    end

    add_foreign_key :donations, :users, column: :sending_user_id
    add_foreign_key :donations, :users, column: :receiving_user_id

    add_foreign_key :donations, :books, column: :sended_book_id
  end
end
