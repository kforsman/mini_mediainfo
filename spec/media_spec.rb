require 'spec_helper'
require 'support/test_server'
require 'rspec'
require "mini_mediainfo/media"
require "net/http"


describe MiniMediainfo::Media do

  context "when introspecting files" do

    it "should introspect audio file" do
      media = MiniMediainfo::Media.new("spec/support/small.mp4")
      media.should_not be_nil
      media.introspect
      should_have_proper_data(media.meta)
    end

  end

  context "when introspecting over http" do

    before(:all) do
      @server_thread = Thread.new {TestServer.run!}
      sleep(1)
    end

    after(:all) do
      @server_thread.kill
    end

    it "should introspect video url" do
      res = Net::HTTP.start('localhost', 4567) { |http| http.get('/small.mp4') }
      res.code.should == '200'

      media = MiniMediainfo::Media.new("http://localhost:4567/small.mp4")
      media.should_not be_nil
      media.introspect
      should_have_proper_data(media.meta)
    end
  end

  def should_have_proper_data(meta_data)
    meta_data.is_a?(Hash).should be true

    ['General', 'Audio', 'Video'].each do |k|
      meta_data.has_key?(k).should be true
      meta_data[k].size.should > 0
    end
    # test format for a couple of key properties
    number_format = /^[\d]+(\.[\d]+){0,1}$/
    meta_data['General']['Duration'].should match(number_format) #ms
    meta_data['Video']['Codec ID'].should_not be_nil # avc1
    meta_data['Video']['Frame rate'].should match(number_format) # (fps)
    meta_data['Video']['Width'].should match(number_format) # 1280
    meta_data['Video']['Height'].should match(number_format) # 1280
    meta_data['Video']['Format profile'].should_not be_nil # Main@L3.2
    meta_data['Video']['Bit rate'].should match(number_format) # 1280
    meta_data['Audio']['Bit rate'].should match(number_format) # 1280
    meta_data['Audio']['Codec'].should_not be_nil # AAC
  end
end
