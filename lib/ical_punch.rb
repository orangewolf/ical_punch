# $Id$
require 'icalendar'
require 'date'

# Equivalent to a header guard in C/C++
# Used to prevent the class/module from being loaded more than once
unless defined? IcalPunch

module IcalPunch
  class << self
    
    def data
      @data
    end
    
    def data=(value)
      @data = value
    end
    
    def load(file_path = '~/.punch.yml')
      begin
        raw = File.read(File.expand_path(file_path))
        @data = YAML.load(raw)
      rescue Errno::ENOENT
        return false
      end
      
      true
    end
    
    def calendars
      @calendars = []
      data.each do |key, value|
        calendar = Icalendar::Calendar.new
        value.each do |entry|
          calendar.event do
            dtstart     entry["in"].strftime("%Y%m%dT%H%M%S")
            dtend       entry["out"].strftime("%Y%m%dT%H%M%S")
            summary     key
            description entry["log"].join("\n")
          end
        end
        @calendars << calendar
      end
      @calendars
    end
    
    def to_ical(file_path = "~/punch.ics")
      File.open(file_path, "w") do |file|
        file.write(calendars.to_ical)
      end
    end
  end
  
  

  # :stopdoc:
  VERSION = '0.5.0'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, *args)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, *args)
  end

  # Utility method used to rquire all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end

end  # module IcalPunch

IcalPunch.require_all_libs_relative_to __FILE__

end  # unless defined?

# EOF
