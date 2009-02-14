require File.dirname(__FILE__) + '/spec_helper'

describe Bloggy do
  
  before do
    Bloggy.folder = fixture_path
  end
  
  describe '.all' do
    it "should return a list of posts" do
      all = Bloggy.all
      all.map! { |p| p.slug }
      all.should include('monkey')
      all.should include('seek-nirvana')
      all.should include('activerecord-shenanigans')
    end
    
    it "should sort by date in a descending order" do
      all = Bloggy.all
      all.map! { |p| p.slug }
      all.should == ['seek-nirvana', 'activerecord-shenanigans', 'monkey', 'hostile-takeover']
    end
  end
  
  describe '.find' do
    it "should be nil if the slug doesn't exit" do
      Bloggy.find('hello-world').should be_nil
    end
    
    it "should return a post" do
      post = Bloggy.find('activerecord-shenanigans')
      post.slug.should == 'activerecord-shenanigans'
      post.published_on.should == Date.civil(2008, 9, 12)
      post.title.should == 'How to Cheat at AR'
    end
  end
  
  describe '.published' do
    it "should return a list of published posts" do
      all = Bloggy.published
      all.map! { |p| p.slug }
      all.should include('monkey')
      all.should_not include('seek-nirvana')
      all.should include('activerecord-shenanigans')
    end
    
    it "should sort by date in a descending order" do
      all = Bloggy.published
      all.map! { |p| p.slug }
      all.should == ['activerecord-shenanigans', 'monkey', 'hostile-takeover']
    end
  end
  
end