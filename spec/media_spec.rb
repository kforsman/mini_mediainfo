require 'spec_helper'
require 'support/test_server'
require 'rspec'
require "mini_mediainfo/media"
require "net/http"

describe MiniMediainfo::Media do

  context "when introspecting files" do

    it "should introspect audio file" do
      media = MiniMediainfo::Media.new("spec/support/small.mp4")
      expect(media).to_not be_nil
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
      expect(res.code).to eq('200')

      media = MiniMediainfo::Media.new("http://localhost:4567/small.mp4")
      expect(media).to_not be_nil
      media.introspect
      should_have_proper_data(media.meta)
    end
  end

  def should_have_proper_data(meta_data)
    expect(meta_data).to be_a(Hash)

    ['General', 'Audio', 'Video'].each do |k|
      expect(meta_data).to have_key(k)
      expect(meta_data[k]).to_not be_empty
    end
    # test format for a couple of key properties
    number_format = /^[\d]+(\.[\d]+){0,1}$/

    expect(meta_data['General']['Duration']).to match(number_format) #ms
    expect(meta_data['Video']['Codec ID']).to_not be_nil # avc1
    expect(meta_data['Video']['Frame rate']).to match(number_format) # (fps)
    expect(meta_data['Video']['Width']).to match(number_format) # 1280
    expect(meta_data['Video']['Height']).to match(number_format) # 1280
    expect(meta_data['Video']['Format profile']).to_not be_nil # Main@L3.2
    expect(meta_data['Video']['Bit rate']).to match(number_format) # 1280
    expect(meta_data['Audio']['Bit rate']).to match(number_format) # 1280
    expect(meta_data['Audio']['Codec']).to_not be_nil # AAC
  end
end
