# $Id$
__DIR__ = File.dirname(__FILE__)

require File.join(File.dirname(__FILE__), %w[spec_helper])

describe IcalPunch do
  it "should load a punch file" do
    IcalPunch.data.should be_nil
    IcalPunch.load
    IcalPunch.data.should_not be_nil
  end
  
  it "should output ical from punch data" do
    IcalPunch.load(File.join("spec", "fixtures", "punch.yml"))
    IcalPunch.calendars.each do |ical|
      Icalendar.parse(ical.to_ical).first.events.first.dtend.should == DateTime.parse("2008-09-02T18:30:00")
    end
  end
  
  it "should write an ical from punch data" do
    tmp_dir = File.join(__DIR__, "tmp")
    FileUtils.rm_rf(tmp_dir)
    FileUtils.mkdir(tmp_dir)
    IcalPunch.load(File.join("spec", "fixtures", "punch.yml"))
    IcalPunch.to_ical(File.join(tmp_dir, "test.ics"))
  end
end

# EOF
