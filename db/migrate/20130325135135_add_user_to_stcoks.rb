class AddUserToStcoks < ActiveRecord::Migration
  def change
    change_table :stocks do |t|
      t.integer :user_id
    end
  end
end
