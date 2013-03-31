class AddUserTypeToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.rename :type, :product_type
    end
  end
end
