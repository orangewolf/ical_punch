# $Id$
require 'rubygems'
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
    
    def calendars
      @calendars
    end
    
    def calendars=(value)
      @calendars = value
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
    
    def write(file_path = "~/.punch.yml")
      File.open(File.expand_path(file_path), 'w') do |file|
        file.puts @data.to_yaml
      end
    end
    
    def punch_to_calendars
      data.keys.each do |key|
        punch_to_calendar(key)
      end
    end
    
    def punch_to_calendar(project)
      @calendars = []
      value = data[project]
      calendar = Icalendar::Calendar.new
      calendar.prodid += "/#{project}"
      value.each do |entry|
        check_entry(entry) || next
        start_time = entry["in"].strftime("%Y%m%dT%H%M%S")
        end_time   = entry["out"].strftime("%Y%m%dT%H%M%S")
        calendar.event do
          dtstart     start_time
          dtend       end_time
          summary     project
          description entry["log"].join("\n")
        end
      end
      @calendars << calendar
      @calendars
    end
    
    def check_entry(entry)
      if entry["in"].nil?
        puts "Error processing start time for #{entry.inspect}"
        return false
      end
      if entry["out"].nil?
         puts "Error processing end time for #{entry.inspect}"
         return false
      end
      return true
    end
    
    def calendars_to_punch
      @data = {}
      @calendars.each do |calendar|
        key = calendar.prodid.split("/").last
        @data[key] = calendar.events.collect do |event|
          {"out" => event.dtend, "in" => event.dtstart, "total" => nil, "log" => event.description.to_s}
        end
      end
      return @data
    end
    
    def to_ical(project_name, file_path = "~/punch.ics")
      File.open(File.expand_path(file_path), "w") do |file|
        file.write(punch_to_calendar(project_name).to_ical)
      end
    end
    
    def from_ical(file_path = "~/punch.ics")
      File.open(File.expand_path(file_path), "r") do |file|
        @calendars = Icalendar.parse(file)
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
