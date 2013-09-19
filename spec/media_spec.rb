require 'spec_helper'
require 'support/test_server'
require 'rspec'
require "mini_mediainfo/media"
require "net/http"


describe MiniMediainfo::Media do

  context "when introspecting files" do

    it "should introspect audio file" do
      media = MiniMediainfo::Media.new("spec/fixtures/napoleon.mp3")
      media.should_not be_nil
      media.introspect
      media.meta.is_a?(Hash).should be_true
      ['General', 'Audio'].each do |k|
        media.meta.has_key?(k).should be_true
        media.meta[k].size.should > 0
      end
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
      media.meta.is_a?(Hash).should be_true
      ['General', 'Audio', 'Video'].each do |k|
        media.meta.has_key?(k).should be_true
        media.meta[k].size.should > 0
      end

    end
  end
end