class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :pname
      t.string :password
      t.string :password_digest
      t.string :email
      t.string :category
      t.integer :business_id

      t.timestamps
    end
  end
end
