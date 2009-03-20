$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'lilliput'
require 'spec'

def fixture_path(filename='')
  File.join(File.dirname(__FILE__), 'fixtures', filename)
end