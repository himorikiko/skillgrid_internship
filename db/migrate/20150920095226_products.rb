class Products < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :products, [:user_id, :created_at], name: "index_products_on_user_id_and_created_at", using: :btree

  end
end
