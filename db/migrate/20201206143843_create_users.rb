class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :num
      t.string :major
      t.string :department
      t.string :password_digest
      t.boolean :admin, default: false
      t.boolean :teacher, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
