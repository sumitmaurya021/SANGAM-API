class CreateRememberTokensAndOtpAttempts < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :otp_attempts, :integer, default: 0, null: false
    add_column :users, :remember_me_pending, :boolean, default: false, null: false

    create_table :remember_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token_hash, null: false
      t.datetime :expires_at, null: false
      t.timestamps
    end

    add_index :remember_tokens, :token_hash, unique: true

    # Remove OmniAuth columns
    if index_exists?(:users, [:provider, :uid])
      remove_index :users, name: :index_users_on_provider_and_uid
    end
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
