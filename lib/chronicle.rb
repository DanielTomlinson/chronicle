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
    
    def generate
      is_valid = Proc.new {|msg| msg.include?(@char)}
      
      commits = @log.map {|hash| @git.gcommit(hash).message}.select(&is_valid)
      lines = commits.map {|msg| msg.split(/\r?\n/).select(&is_valid)}
      release_notes = lines.flatten.join("\n").gsub!(@char, "-")
      
      return release_notes
    end
  end
end
