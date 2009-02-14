require File.dirname(__FILE__) + '/spec_helper'

describe Bloggy::Post do
  
  before do
    @shenanigans = Bloggy::Post.new fixture_path('2008-09-12-activerecord-shenanigans.md')
    @nirvana = Bloggy::Post.new fixture_path('2020-02-03-seek-nirvana.md')
    @hostile = Bloggy::Post.new fixture_path('2006-05-12.md')
  end
  
  describe '#author' do
    it "should get the author from the last line" do
      @hostile.author.should == 'Jonas Nicklas'
    end
  end
  
  describe '#email' do
    it "should get the email from the last line" do
      @hostile.email.should == 'jonas.nicklas@gmail.com'
    end
  end
  
  describe '#published_on' do
    it "should get the date from the filename" do
      @shenanigans.published_on.should == Date.civil(2008, 9, 12)
    end
  end
  
  describe '#slug' do
    it "should get the slug from the filename" do
      @shenanigans.slug.should == 'activerecord-shenanigans'
    end
    
    it "should get the slug from the first line if not in filename" do
      @hostile.slug.should == 'hostile-takeover'
    end
  end
  
  describe '#title' do
    it "should get the title from the first line" do
      @shenanigans.title.should == 'How to Cheat at AR'
    end
  end
  
  describe '#contents' do
    it "should get the contents" do
      @shenanigans.content.should == File.read(fixture_path('2008-09-12-activerecord-shenanigans.md'))
    end
  end
  
  describe '#html' do
    it "should transform the contents to html" do
      @shenanigans.html.should =~ %r(<h1 id='how_to_cheat_at_ar'>How to Cheat at AR</h1>)
    end
  end
  
  describe '#published?' do
    it "should be true if the published on date is in the past" do
      @shenanigans.should be_published
    end
    
    it "should be false if the published on date is in the future" do
      @nirvana.should_not be_published
    end
  end
  
end