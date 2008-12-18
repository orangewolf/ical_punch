# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ical_punch}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Kaufman"]
  s.date = %q{2008-12-17}
  s.default_executable = %q{ical_punch}
  s.description = %q{ical_punch converts between iCalendar files and the punch.yml format}
  s.email = %q{rob@notch8.com}
  s.executables = ["ical_punch"]
  s.extra_rdoc_files = ["History.txt", "README.txt", "bin/ical_punch"]
  s.files = [".gitignore", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/ical_punch", "ical_punch.gemspec", "lib/ical_punch.rb", "spec/fixtures/punch.yml", "spec/ical_punch_spec.rb", "spec/spec_helper.rb", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/manifest.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake"]
  s.has_rdoc = true
  s.homepage = %q{github.com/notch8}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ical_punch}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{ical_punch converts between iCalendar files and the punch}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
