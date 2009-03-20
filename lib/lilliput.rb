require 'maruku'

module Lilliput
  
  class << self
    
    attr_accessor :folder, :author, :email, :show_unpublished
  
    def all
      files = Dir.glob(File.join(folder, '*')).reverse
      posts = files.map { |f| Post.new(f) }
      posts = posts.select { |p| p.published? } unless Lilliput.show_unpublished
      posts
    end
  
    def find(slug)
      all.select{ |p| p.slug == slug }.first
    end
    
    def first
      all.first
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
      credentials[0] || Lilliput.author
    end
    
    def email
      credentials[1] || Lilliput.email
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
      strip_off_blank_lines(lines[1..-1]).join("\n")
    end
    
    def html
      Maruku.new(content).to_html
    end
    
    def previous
      Lilliput.all[post_nr + 1]
    end
    
    def next
      Lilliput.all[post_nr - 1] unless post_nr <= 0
    end
    
    def ==(other_post)
      slug == other_post.slug
    end
    
  private
  
    def post_nr
      Lilliput.all.map { |p| p.slug == slug }.index(true)
    end
  
    def strip_off_blank_lines(lines)
      until lines.first =~ /[^\s=]/ or lines.empty?
        lines.shift
      end
      until lines.last =~ /[^\s=]/ or lines.empty?
        lines.pop
      end
      lines
    end
  
    def read
      File.read(@path)
    end
  
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
      Array(read)
    end
  
    def filename
      File.basename(@path)
    end
    
  end
  
end