class ChangeTypeToOwnership < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.rename :product_type, :ownership
    end
  end
end
