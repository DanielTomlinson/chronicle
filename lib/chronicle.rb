require "chronicle/version"
require "git"

module Chronicle
  class Repository
    def initialize path
      @git = Git.open(path)
    end
    
    def git
      return @git
    end
    
    def git= value
      @git = value
    end
    
    def log
      return GitLog.new(git.log, self)
    end
    
    def log_between first, last
      return GitLog.new(git.log.between(first, last), self)
    end
    
    def log_since first
      return log_between(first, "HEAD")
    end
  end
  
  class GitLog
    def initialize log, repository
      @log = log
      @repository = repository
    end
    
    def commit_messages
      return @log.map {|hash| @repository.git.gcommit(hash).message }
    end
  end
  
  class Generator
    def initialize log
      @log = log
      @char = "<*>"
    end
    
    def character
      return @char
    end
    
    def character= value
      @char = value
    end
    
    def generate
      valid = Proc.new {|msg| msg.include?(@char)}
      split_strings = Proc.new {|str| str.split(/\r?\n/)}
      
      commits = @log.commit_messages.select(&valid)
      lines = commits.map(&split_strings).flatten.select(&valid)
      release_notes = lines.flatten.join("\n").gsub!(@char, "-")
      
      return release_notes
    end
    
  end
end
