require "mini_mediainfo/version"
require 'open3'

module MiniMediainfo

  def self.platform_supported?
    /(darwin|linux|unix)/ =~ RUBY_PLATFORM
  end

  def self.mediainfo_version
    cmd = "mediainfo --version"
    out = Open3.popen3(cmd) { |stdin, stdout, stderr| stdout.read }
    out.gsub("\n","")
  end

  def self.mediainfo_binary
    cmd = "which mediainfo"
    Open3.popen3(cmd) { |stdin, stdout, stderr| stdout.read }
  end

end
