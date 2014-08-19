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
      @char = nil
    end
    
    def character
      return @char
    end
    
    def character= value
      @char = value
    end
    
    def commits
      return @log.commit_messages.select{|m| self.valid_commit? m}
    end
    
    def commit_summaries
      return commits.map {|str| str.split(/\r?\n/).first }
    end
    
    def changes
      if @char == nil
        return self.commit_summaries
      else
        return self.commits.map{|str| str.split(/\r?\n/)}.flatten.select{|m| self.valid_commit? m}
      end
    end
    
    def generate
      lines = changes
      release_notes = lines
      
      return release_notes
    end
    
    def valid_commit? commit
      if @char
        return commit.include? @char
      else
        return commit.length > 0
      end
    end
    
  end
end
