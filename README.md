# MiniMediainfo

A Ruby wrapper for mediainfo CLI.

## Installation

As a prerequisite you will need to have the mediainfo binary installed on your system.
For example:

OS X:

    brew install mediainfo

Ubuntu:

    sudo add-apt-repository ppa:shiki/mediainfo
    sudo apt-get update
    sudo apt-get install mediainfo



Add this line to your application's Gemfile:

    gem 'mini_mediainfo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_mediainfo

## Usage

    require 'mini_mediainfo'
    media = MiniMediainfo::Media.new("http://techslides.com/demos/sample-videos/small.mp4")
    media.introspect
    media.meta['General']['Format'] # => "MPEG-4"
    media.meta['General']['Duration'] # => "12345667"
    media.meta['Audio']['Compression mode'] # => "Lossy"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
