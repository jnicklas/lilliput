require 'maruku'

module Bloggy
  
  class << self
    
    attr_accessor :folder
  
    def all
      Dir.glob(File.join(folder, '*')).reverse.map { |f| Post.new(f) }
    end
  
    def published
      all.select { |p| p.published? }
    end
  
    def find(slug)
      all.select{ |p| p.slug == slug }.first
    end
  
  end
  
  class Post
    
    def initialize(path)
      @path = path
    end
    
    def published_on
      date = filename.match(/^([\d]{4}-[\d]{2}-[\d]{2})/)[1]
      Date.parse(date) if date
    end
    
    def published?
      published_on < Date.today
    end
    
    def title
      lines.first.chomp
    end
    
    def author
      credentials[0]
    end
    
    def email
      credentials[1]
    end
    
    def slug
      slug = filename.match(/^[\d]{4}-[\d]{2}-[\d]{2}-([a-z0-9\-]+)/i)
      if slug
        slug[1]
      else
        lines.first.downcase.gsub(/[^a-z0-9\-]/, '-').gsub(/^\-*(.*?)\-*$/, '\1')
      end
    end
    
    def content
      File.read(@path)
    end
    
    def html
      Maruku.new(content).to_html
    end
    
  private
  
    def credentials
      match = lines.last.match(/\/(.*?)(?:<(.*?)>)?[\s]*$/)
      if match
        author = match[1].strip
        email = match[2].strip
        return [author, email]
      end
      [nil, nil]
    end
  
    def lines
      Array(content)
    end
  
    def filename
      File.basename(@path)
    end
    
  end
  
end