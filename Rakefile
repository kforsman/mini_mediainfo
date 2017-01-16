require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require_relative 'lib/mini_mediainfo/media'

RSpec::Core::RakeTask.new('spec')

task :default => :spec

desc "Introspects a video, example: bundle exec rake introspect['http://some-site.com/video.mp4']"
task :introspect, [:url] do |t, args|
  url = args[:url]
  m = MiniMediainfo::Media.new(url)
  m.introspect
  puts m.meta
end
