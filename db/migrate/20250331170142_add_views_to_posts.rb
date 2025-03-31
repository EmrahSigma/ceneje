class AddViewsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :views, :integer
  end
end
