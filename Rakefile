# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'ical_punch'

task :default => 'spec:run'

PROJ.name = 'ical_punch'
PROJ.authors = 'Rob Kaufman'
PROJ.email = 'rob@notch8.com'
PROJ.url = 'github.com/notch8'
PROJ.rubyforge.name = 'ical_punch'

PROJ.spec.opts << '--color'

# EOF
