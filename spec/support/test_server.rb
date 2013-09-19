require 'rack'
require 'thin'
require 'sinatra'

class TestServer < Sinatra::Base

  APP_ROOT = './spec/support'

  get '*' do
    rpath=File.join(APP_ROOT,params[:splat][0][1..-1])
    mimetype = `file -Ib #{rpath}`.gsub(/\n/,"")
    #puts "serving #{rpath} with mimetype #{mimetype}"
    send_file rpath, :stream=>true, :type=>mimetype, :disposition=>:inline
  end

end

#t = Thread.new {TestServer.run!}
#t.join



