class BlogCLI::CLI
  attr_reader :last_input

  def call
    puts "Welcome to your CLI Blog!"
    menu
  end

  def menu
    puts "What would you like to do?"
    puts "1. Write a post"
    main_menu_loop
  end

  def main_menu_loop
    while user_input != "exit"
      case last_input.to_i
      when 1
        post_new
      else
        menu
        break
      end
    end
  end

  def post_new
    params = {}

    puts "Please enter the title of your new post:"
    params[:title] = user_input

    puts "Please enter the content of your new post:"
    params[:content] = user_input

    post = BlogCLI::Post.new(params)

    post.save
  end

  private

    def user_input
      @last_input = gets.strip
    end

end
