class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def self.up
    change_table :users do |t|
      # Only add the email column if it doesn't already exist
      unless column_exists?(:users, :email)
        t.string :email, null: false, default: ""
      end

      # Only add the encrypted_password column if it doesn't already exist
      unless column_exists?(:users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      # Only add the reset_password_token column if it doesn't already exist
      unless column_exists?(:users, :reset_password_token)
        t.string :reset_password_token
      end

      # Only add the reset_password_sent_at column if it doesn't already exist
      unless column_exists?(:users, :reset_password_sent_at)
        t.datetime :reset_password_sent_at
      end

      # Only add the remember_created_at column if it doesn't already exist
      unless column_exists?(:users, :remember_created_at)
        t.datetime :remember_created_at
      end
    end

    # Check if the email index already exists, if not, add it
    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end

    # Check if the reset_password_token index already exists, if not, add it
    unless index_exists?(:users, :reset_password_token)
      add_index :users, :reset_password_token, unique: true
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
