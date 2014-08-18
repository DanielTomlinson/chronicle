require "chronicle/version"
require "git"

module Chronicle
  class Generator
    def initialize
      @git = Git.open(Dir.pwd)
      @char = "<*>"
    end
    
    def log
      return @log
    end
    
    def log= value
      @log = value
    end
    
    def character
      return @char
    end
    
    def character= value
      @char = value
    end
    
    def log_between first, last
      @log = @git.log.between first, last
    end
    
    def generate
      puts "Generating from hashes: #{@log} | Character is: #{@char}"
      commits = @log.map {|hash| @git.gcommit(hash).message}.compact
      commits = commits.select {|message| message.include?(@char)}
      puts "Commits are: #{commits}"
    end
  end
end
