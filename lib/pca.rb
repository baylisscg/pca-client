#
#
#

require 'rubygems' if RUBY_VERSION =~ /^1\.8/

unless defined? Bundler  
 require 'bundler'
 Bundler.setup
end

require "sinatra/base"
require "pp"
require "net/http"

module PCA

  TEMPLATE_PATH = Proc.new { File.join(File.dirname(__FILE__),"..", "templates") } # TODO: This isn't very clean

  class Application < Sinatra::Base

    set :views, PCA::TEMPLATE_PATH
    mime_type :html5, "text/html"
    enable :logging, :dump_errors

    before do
      content_type :html5, :charset => 'utf-8'
    end

    get '/' do
      nokogiri "index.html".to_sym
    end

    get "/subscribe" do
      nokogiri "sub.html".to_sym
    end

    post '/subscribe' do
      hub = request["hub"]
      topic = request["topic"]
      return 404 unless url and topic
      PP.pp request
      
      self.push_sub_request hub, topic
      
      200
    end

    get '/endpoint' do
      PP.pp request

      challenge =  request["hub.challenge"]
      topic =  request["hub.topic"]
      mode =  request["hub.mode"]
      lease =  request["hub.lease_seconds"]

      [200,challenge]

    end

    post "/endpoint" do
      PP.pp request
      200
    end

    def push_sub_request(url,topic)
      target = URI.parse url
      client = Net::HTTP.new target.host, target.port
      form_data = { "hub.callback"=>"http://localhost:8081/endpoint",
        "hub.mode" => "subscribe",
        "hub.topic" => topic,
        "hub.verify" => "sync" }
      response =  Net::HTTP.post_form target, form_data

      PP.pp response
      PP.pp response.body

    end

  end
end



