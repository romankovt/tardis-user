# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :phone
      t.string :email
      t.string :first_name
      t.string :last_name
      t.timestamp :phone_confirmed_at

      t.timestamps
    end

    add_index :users, :phone, unique: true
    add_index :users, :email, unique: true
  end
end
