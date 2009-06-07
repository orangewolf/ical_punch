# $Id$
require 'rubygems'
__DIR__ = File.dirname(__FILE__)

require File.join(File.dirname(__FILE__), %w[spec_helper])

describe IcalPunch do
  it "should load a punch file" do
    IcalPunch.data.should be_nil
    IcalPunch.load
    IcalPunch.data.should_not be_nil
  end
  
  it "should output ical from punch data" do
    IcalPunch.load(File.join("fixtures", "punch.yml"))
    IcalPunch.punch_to_calendars
    IcalPunch.calendars.each do |ical|
      Icalendar.parse(ical.to_ical).first.events.first.dtend.should == DateTime.parse("2008-09-02T18:30:00")
    end
  end
  
  it "should write an ical from punch data" do
    tmp_dir = File.join(__DIR__, "tmp")
    FileUtils.rm_rf(tmp_dir)
    FileUtils.mkdir(tmp_dir)
    IcalPunch.load(File.join(__DIR__, "fixtures", "punch.yml"))
    IcalPunch.to_ical("assay_depot", File.join(tmp_dir, "test.ics"))
  end
  
  it "should read an ical from an ical file" do
    IcalPunch.calendars = nil
    IcalPunch.calendars.should be_nil
    IcalPunch.from_ical(File.join(__DIR__, "fixtures", "test.ics"))
    IcalPunch.calendars.should_not be_nil
    IcalPunch.calendars.should be_instance_of(Array)
  end
  
  it "should output punch from ical" do
    original_data = IcalPunch.data
    IcalPunch.data = nil
    IcalPunch.data.should be_nil

    IcalPunch.calendars = nil
    IcalPunch.calendars.should be_nil
    
    IcalPunch.from_ical(File.join(__DIR__, "fixtures", "test.ics"))
    IcalPunch.calendars_to_punch
    IcalPunch.data.should_not be_nil
    #IcalPunch.data.to_yaml.should be_eql(original_data.to_yaml)
  end

end
# EOF
