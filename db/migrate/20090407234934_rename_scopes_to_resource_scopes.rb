class RenameScopesToResourceScopes < ActiveRecord::Migration
  def self.up
    rename_table :scopes, :resource_scopes
  end

  def self.down
    rename_table :resource_scopes, :scopes
  end
end
