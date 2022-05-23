class CreateExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :exchanges do |t|
    t.integer :sending_status
    t.integer :recieving_status
    t.integer :process_status
    t.integer :type_of_exchange
    t.string :details
    t.boolean :deleted, default: false

    t.references :sending_user, null: false
    t.references :recieving_user, null: true

    t.references :sended_book, null: false
    t.references :recieved_book, null: true

    t.timestamps
    end

    add_foreign_key :exchanges, :users, column: :sending_user_id
    add_foreign_key :exchanges, :users, column: :recieving_user_id

    add_foreign_key :exchanges, :books, column: :sended_book_id
    add_foreign_key :exchanges, :books, column: :recieved_book_id
  end
end
