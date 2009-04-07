class Resource < ActiveRecord::Base
  belongs_to :child_sp
  has_many :resource_scopes
  has_many :client_applications, :through => :resource_scopes
end
