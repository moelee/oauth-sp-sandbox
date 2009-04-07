class ModifiedOauthToken < ActiveRecord::Migration
  def self.up
    add_column(:client_applications, :public_key, :text)
    add_column(:oauth_tokens, :expires_on, :timestamp)
    
    create_table :child_sps do |t|
      t.string :base_url
      t.string :shared_secret
    
      t.timestamps
    end

    create_table :resources do |t|
      t.string :name
      t.integer :child_sp_id

      t.timestamps
    end

    create_table (:client_application_resources, :primary_key => false) do |t|
      t.integer :client_application_id
      t.integer :resource_id
    end

  end

  def self.down
    remove_column(:client_applications, :public_key)
    remove_column(:oauth_tokens, :expires_on)
    drop_table :child_sps
    drop_table :resources
    drop_table :client_application_resources
  end
end
