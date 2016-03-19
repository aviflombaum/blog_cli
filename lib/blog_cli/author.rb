class BlogCLI::Author < ActiveRecord::Base
  has_many :posts
  
end
