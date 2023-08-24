require('thor')
require('pathname')

BLOG_PATH = ENV['BLOG_PATH']

if BLOG_PATH.nil?
  puts('Error: BLOG_PATH is not specificated!')
  puts('Plesse set $BLOG_PATH on your shell.')
  exit
end

tmpl = ''

class CLI < Thor
  desc 'new', 'crate new content.'
  def new(arg)
    case arg
    in 'post'
      puts('Please input title.')
      title = STDIN.gets.chomp

      puts('Please input description.')
      description = STDIN.gets.chomp

      now = Time.now
      file_name = "#{now.strftime('%Y-%m-%d')}-#{title}.md"

      now = Time.now

      text = <<~EOS
        ---
        title: "#{title}"
        description: "#{description}"
        pubDate: "#{now.strftime('%b %d %Y')}"
        emoji: "🦊"
        ---
      EOS

      file = File.new(Pathname(BLOG_PATH) + file_name, 'w')
      file.puts(text)
      file.close

      # puts(text)

      puts('create new post!')
    else
      puts('Error: This subcommand is not valid.')
      puts('Can use subcommand is here.')
      ['post'].map do |item|
        puts("- #{item}")
      end
    end
  end

  desc 'path', 'Show path to blog contents directory'
  def path
    path = ENV['BLOG_PATH']

    case path
    in nil
      puts('Nothing')
    else
      puts path
    end
  end
end

CLI.start(ARGV)
