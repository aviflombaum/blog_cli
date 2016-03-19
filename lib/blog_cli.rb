require_relative '../config/environment'

ActiveRecord::Migration.check_pending!

module BlogCLI
end

require "blog_cli/version"
require "blog_cli/cli"
require "blog_cli/post"
require "blog_cli/author"
require "blog_cli/category"
