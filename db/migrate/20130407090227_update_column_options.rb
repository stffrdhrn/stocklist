class UpdateColumnOptions < ActiveRecord::Migration
  def up
    change_column :users, :name, :string, {:limit => 64, :null=>false}

    change_column :stocks, :name, :string, {:limit => 64, :null=>false}
    change_column :stocks, :user_id, :string, {:null=>false}

    change_column :products, :name, :string, {:limit => 64, :null=>false}
    change_column :products, :category, :string, {:limit => 4, :null=>false}
    change_column :products, :ownership, :string, {:null=>false}

    change_column :product_stocks, :quantity, :integer, {:null => false, :default => 1}
  end

  def down
  end
end
