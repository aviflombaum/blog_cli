class BlogCLI::CLI
  attr_reader :last_input, :current_user

  def call
    puts "Welcome to your CLI Blog!"
    login
    menu
  end

  def login
    puts "Please enter your name to login:"
    @current_user = BlogCLI::Author.find_or_create_by(:name => user_input)
    puts "You're now logged in as: #{current_user.name}"
  end

  def menu
    puts "What would you like to do?"
    puts "1. Write a post"
    puts "2. List your posts"
    puts "3. List all posts"
    main_menu_loop
  end

  def main_menu_loop
    while user_input != "exit"
      case last_input.to_i
      when 1
        post_new
        break
      when 2
        post_index
        break
      else
        menu
        break
      end
    end
  end

  def post_index
    puts "--- Posts by you, #{current_user.name} ---"
    # How to print out each post by this user with an ID and a Title
    current_user.posts.each do |post|
      puts "#{post.id}. #{post.title}"
    end

    puts "Enter the Post ID you'd like to see or edit or go back to the main menu:"
    if user_input.to_i > 0
      post_show
    else
      menu
    end
  end

  def post_show
    puts "Loading Post #{last_input}..."
    # When we load this post, it 100% belongs to the current_user
    # begin
    #   post = current_user.posts.find(last_input)
    if post = current_user.posts.find_by(:id => last_input)
      puts "--- #{post.id} --- #{post.title}"
      puts
      puts post.content
    else
    # rescue ActiveRecord::RecordNotFound
      puts "Can't find a post with ID #{last_input} for you..."
    end
    menu
  end

  def post_new
    params = {}
    # When we're creating a Blog Post, assuming the author already exists
    # How many SQL Statements should fire?
    # 1 SQL Statement - an "INSERT INTO posts"

    # post = BlogCLI::Post.new(params)
    # How can I associate this blog post with author?
    # in 2 ways.

    # 1. Let's manually assign the current_user as the author of this post
    # post.author = current_user

    # Why this is bad.
    # Will load all of an authors posts into memory
    # even though we don't need them!!!
    # current_user.posts << post

    puts "Please enter the title of your new post:"
    params[:title] = user_input

    puts "Please enter the content of your new post:"
    params[:content] = user_input

    # 2. Let's actually instantiate the post already associated with the
    # current_user
    post = current_user.posts.build(params)
    post.save # Insert the Post with the author_id FK
    puts "Saved Post ##{post.id}..."
    menu
  end

  private

    def user_input
      @last_input = gets.strip
    end

end
