#require "mini_mediainfo/version"
require 'open3'

module MiniMediainfo

  class Media

    attr_reader :uri

    def initialize(uri, options={})
      unless File.exists?(uri)
        if uri =~ URI::regexp(["ftp", "http", "https"])
          url = URI.parse(uri)
          req = Net::HTTP.new(url.host, url.port)
          res = req.request_head(url.path)
          if res.code != "200"
            raise "Error: #{uri} is not accessible"
          end
        else
          raise "Error: the file '#{uri}' does not exist"
        end
      end
      @uri = uri
      @introspection_data = {}
    end

    def introspect()
      cmd = "mediainfo \"#{@uri}\""
      key = ''
      lines = []
      keys = []
      entries = []

      Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
        while line = stdout_err.gets
          lines << line
        end

        exit_status = wait_thr.value
        unless exit_status.success?
          abort "FAILED !!! #{cmd}"
        end
      end

      key = ''
      lines.each do |l|
        if l.index(':').to_i > 0
          media_attrs = [l.slice(0..l.index(':')-1), l.slice(l.index(':')+1..-1)].collect {|a| a.strip}
        else
          if l.strip.length > 0
            key = l.strip
            keys.push(key)
          end
        end

        if (key && key.length > 0) && (media_attrs && media_attrs.length == 2)
          entries.push([key, media_attrs[0], media_attrs[1]])
        end
      end

      keys.each do |k|
        per_key_entries = entries.select {|e| e[0] == k}
        per_key_hash = Hash[per_key_entries.each {|e| e.shift}]
        @introspection_data[k] = per_key_hash
      end
    end

    def meta()
      return @introspection_data
    end

  end

end
