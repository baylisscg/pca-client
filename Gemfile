#

source :rubygems

gem "rake"
gem "sinatra"
gem "nokogiri"

gem "jruby-openssl" if RUBY_PLATFORM == "java"

#
# Use the thin webserver while developing
#
group :development do

  if RUBY_PLATFORM == "java"
    gem "trinidad"
  else
    gem "shotgun"
    gem "mongrel", ">=1.2.0pre" # We need a multiprocessing HTTP server. 
  end

end

#
# We test with RSpec2 and rack-test
#
group :test do
  
  gem "rspec"
  gem "rack-test"
  gem "faker"
  gem "machinist"
  
end
