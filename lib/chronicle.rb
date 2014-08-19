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
    
    def log_since first
      @log = @git.log.between first, "HEAD"
    end
    
    def commit_messages
      @log.map {|hash| @git.gcommit(hash).message }
    end
    
    def generate
      valid = Proc.new {|msg| msg.include?(@char)}
      split_strings = Proc.new {|str| str.split(/\r?\n/)}
      
      commits = self.commit_messages.select(&valid)
      lines = commits.map(&split_strings).flatten.select(&valid)
      release_notes = lines.flatten.join("\n").gsub!(@char, "-")
      
      return release_notes
    end
    
  end
end
