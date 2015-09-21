class AddFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :avatar
      t.string :birth_date
      t.string :passport_photo
      t.string :shop_title
    end
  end
end
