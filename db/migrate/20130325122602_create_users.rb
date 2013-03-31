class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, { :limit => 12 }

      t.timestamps
    end
  end
end
