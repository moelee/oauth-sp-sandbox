class Photo < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :s3,
                 :max_size => 10.megabytes
  
  validates_as_attachment
  
  # Constants
  DEFAULT_RETURN_METHODS = [:public_filename]
  
          
end
