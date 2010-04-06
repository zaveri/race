class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations, :force => true do |t|
      t.string :login, :crypted_password, :salt, :remember_token, :limit => 40
      t.datetime :remember_token_expires_at
      t.string :name,                      :limit => 100, :default => '', :null => true
      t.string :email,                     :limit => 100
      t.timestamps
    end
    add_index :organizations, :login, :unique => true
  end

  def self.down
    drop_table :organizations
  end
end
