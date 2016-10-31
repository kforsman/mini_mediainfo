require 'spec_helper'

describe MiniMediainfo do

  it "should determine if the platform is supported" do
    subject.respond_to?(:platform_supported?).should be true
    subject.platform_supported?.should be true
  end

  it "should get mediainfo version" do
    version = subject.mediainfo_version
    version.should_not be_nil
    version.should match(/MediaInfoLib - v/)
  end

  it "should tell which mediainfo binary" do
    subject.mediainfo_binary.should match /\/mediainfo/
  end

end
