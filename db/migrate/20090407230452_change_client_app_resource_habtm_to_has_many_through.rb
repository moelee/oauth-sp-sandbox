class ChangeClientAppResourceHabtmToHasManyThrough < ActiveRecord::Migration
  def self.up
    create_table :scopes do |t|
      t.integer :client_application_id
      t.integer :resource_id
    end
    
    drop_table :client_application_resources
    
  end

  def self.down
    drop_table :scopes
    
    create_table (:client_application_resources, :primary_key => false) do |t|
      t.integer :client_application_id
      t.integer :resource_id
    end
  end
end
