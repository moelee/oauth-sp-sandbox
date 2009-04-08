class AddTimestampsToResourceScopes < ActiveRecord::Migration
  def self.up
    add_column :resource_scopes, :created_at, :timestamp
    add_column :resource_scopes, :updated_at, :timestamp
  end

  def self.down
    remove_column :resource_scopes, :created_at
    remove_column :resource_scopes, :updated_at
  end
end
