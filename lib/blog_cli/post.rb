class BlogCLI::Post < ActiveRecord::Base
  belongs_to :author # What does this code do?
  # 1. We can create data or we can define methods.
  belongs_to :category

end
