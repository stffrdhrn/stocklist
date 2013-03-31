class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :category
      t.string :name
      t.string :type, { :limit => 4 }

      t.timestamps

      t.integer :user_id
      t.integer :stock_id
    end
  end
end
