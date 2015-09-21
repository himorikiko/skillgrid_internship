class AddShopTitleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shop_title, :string
  end
end
