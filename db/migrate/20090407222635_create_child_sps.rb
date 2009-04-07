class CreateChildSps < ActiveRecord::Migration
  def self.up
    create_table :child_sps do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :child_sps
  end
end
