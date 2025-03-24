class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :ime, :string
    add_column :users, :priimek, :string
    add_column :users, :telefonska_stevilka, :string
    add_column :users, :naslov, :string
    add_column :users, :mesto, :string
  end
end
