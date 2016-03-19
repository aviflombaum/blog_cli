class BlogCLI::Category < ActiveRecord::Base
  has_many :posts
end
