class Scope < ActiveRecord::Base
  belongs_to :client_application
  belongs_to :resource
end
