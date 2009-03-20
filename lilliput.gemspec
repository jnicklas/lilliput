# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{lilliput}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonas Nicklas"]
  s.date = %q{2009-03-20}
  s.description = %q{Super simple blogging engine}
  s.email = %q{jonas.nicklas@gmail.com}
  s.extra_rdoc_files = ["README.md", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README.md", "Rakefile", "TODO", "lib/lilliput.rb", "spec/fixtures", "spec/fixtures/2006-05-12.md", "spec/fixtures/2008-08-10-monkey.md", "spec/fixtures/2008-09-12-activerecord-shenanigans.md", "spec/fixtures/2020-02-03-seek-nirvana.md", "spec/lilliput_spec.rb", "spec/post_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://www.example.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{lilliput}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Super simple blogging engine}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
