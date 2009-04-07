class Resource < ActiveRecord::Base
  belongs_to :child_sps
  has_and_belongs_to_many :client_applications
end
