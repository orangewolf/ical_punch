# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'ical_punch'

task :default => 'spec:run'

PROJ.name = 'ical_punch'
PROJ.authors = 'FIXME (who is writing this software)'
PROJ.email = 'FIXME (your e-mail)'
PROJ.url = 'FIXME (project homepage)'
PROJ.rubyforge.name = 'ical_punch'

PROJ.spec.opts << '--color'

# EOF
