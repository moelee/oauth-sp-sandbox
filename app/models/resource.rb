class Resource < ActiveRecord::Base
  belongs_to :child_sps
  has_many :scopes
  has_many :client_applications, :through => :scopes
end
