require "chronicle/version"
require "git"

module Chronicle
  # Your code goes here...
  class Generator
    def initialize
      @git = Git.open(working_dir, :log => Logger.new(STDOUT))
    end
    
    def generate_between(first, last)
      log = @git.log.between(first, last)
      puts log
    end
  end
end
