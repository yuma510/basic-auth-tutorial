class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :password
      t.timestamps#created_atとupdated_atをつくる
    end#rails db:migrateをする

    add_index :users, :user_id, unique: true #同一のuser_idがデータベースに保存されないようにしている
  end
end
