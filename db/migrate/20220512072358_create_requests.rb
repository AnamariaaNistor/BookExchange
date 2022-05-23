class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :status

      t.references :request_user, null: false
      t.references :exchange_book, null: false
      t.references :exchange_requested, null: false

      t.timestamps
    end

    add_foreign_key :requests, :users, column: :request_user_id
    add_foreign_key :requests, :books, column: :exchange_book_id
    add_foreign_key :requests, :exchanges, column: :exchange_requested_id
  end
end
