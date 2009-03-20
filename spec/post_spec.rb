require File.dirname(__FILE__) + '/spec_helper'

describe Lilliput::Post do
  
  before do
    Lilliput.author = 'Monkey Boy'
    Lilliput.email = 'monkey@example.com'
    Lilliput.folder = fixture_path
    
    @shenanigans = Lilliput::Post.new fixture_path('2008-09-12-activerecord-shenanigans.md')
    @nirvana = Lilliput::Post.new fixture_path('2020-02-03-seek-nirvana.md')
    @hostile = Lilliput::Post.new fixture_path('2006-05-12.md')
    @monkey = Lilliput::Post.new fixture_path('2008-08-10-monkey.md')
  end
  
  describe '#author' do
    it "should get the author from the last line" do
      @hostile.author.should == 'Jonas Nicklas'
    end
    
    it "should get the author from lilliput if there isn't on in the post" do
      @shenanigans.author.should == 'Monkey Boy'
    end
  end
  
  describe '#email' do
    it "should get the email from the last line" do
      @hostile.email.should == 'jonas.nicklas@gmail.com'
    end
    
    it "should get the email from lilliput if there isn't on in the post" do
      @shenanigans.email.should == 'monkey@example.com'
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
    it "should get the contents without the title" do
      @shenanigans.content.should =~ /^Irure dolor/
    end
  end
  
  describe '#html' do
    it "should transform the contents to html" do
      @shenanigans.html.should =~ /<p>Irure dolor/
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
  
  describe '#previous' do
    it "should return the previous published post" do
      @shenanigans.previous.should == @monkey
    end
    
    it "should be nil if there isn't one" do
      @hostile.previous.should be_nil
    end
  end
  
  describe '#next' do
    it "should return the next published post" do
      @hostile.next.should == @monkey
    end
    
    it "should be nil if there isn't one" do
      p @shenanigans.next
      @shenanigans.next.should be_nil
    end
  end
  
end