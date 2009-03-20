require File.dirname(__FILE__) + '/spec_helper'

describe Lilliput do
  
  before do
    Lilliput.folder = fixture_path
  end
  
  describe '.all' do
    it "should return a list of published posts" do
      all = Lilliput.all
      all.map! { |p| p.slug }
      all.should include('monkey')
      all.should_not include('seek-nirvana')
      all.should include('activerecord-shenanigans')
    end
    
    it "should return a list of all posts if show_unpublished is true" do
      Lilliput.show_unpublished = true
      all = Lilliput.all
      all.map! { |p| p.slug }
      all.should include('monkey')
      all.should include('seek-nirvana')
      all.should include('activerecord-shenanigans')
      Lilliput.show_unpublished = nil
    end
    
    it "should sort by date in a descending order" do
      all = Lilliput.all
      all.map! { |p| p.slug }
      all.should == ['activerecord-shenanigans', 'monkey', 'hostile-takeover']
    end
  end
  
  describe '.find' do
    it "should be nil if the slug doesn't exit" do
      Lilliput.find('hello-world').should be_nil
    end
    
    it "only find published posts" do
      Lilliput.find('seek-nirvana').should be_nil
    end
    
    it "find unpublished posts if show_unpublished is true" do
      Lilliput.show_unpublished = true
      Lilliput.find('seek-nirvana').should_not be_nil
      Lilliput.show_unpublished = nil
    end
    
    it "should return a post" do
      post = Lilliput.find('activerecord-shenanigans')
      post.slug.should == 'activerecord-shenanigans'
      post.published_on.should == Date.civil(2008, 9, 12)
      post.title.should == 'How to Cheat at AR'
    end
  end
  
  describe 'first' do
    it "should return the first published post" do
      post = Lilliput.first
      post.slug.should == 'activerecord-shenanigans'
      post.published_on.should == Date.civil(2008, 9, 12)
      post.title.should == 'How to Cheat at AR'
    end
    
    it "return an unpublished post if show_unpublished is true" do
      Lilliput.show_unpublished = true
      post = Lilliput.first
      post.slug.should == 'seek-nirvana'
      Lilliput.show_unpublished = nil
    end
  end
  
  
  
end