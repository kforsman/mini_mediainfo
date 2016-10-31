require 'spec_helper'

describe MiniMediainfo do

  it "should determine if the platform is supported" do
    expect(subject.platform_supported?).to eq(true)
  end

  it "should get mediainfo version" do
    version = subject.mediainfo_version
    expect(version).to_not be_nil
    expect(version).to match(/MediaInfoLib - v/)
  end

  it "should tell which mediainfo binary" do
    expect(subject.mediainfo_binary).to match /\/mediainfo/
  end

end
