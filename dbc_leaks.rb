# gem install json
require 'rubygems'
require 'json'
require 'open-uri'

class Tumblr
  API_URL = "http://api.tumblr.com/v2/tagged?"
  API_KEY = "fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"
  DEFAULT_TAG = "fiddlercrabs"

  def self.fetch_raw(tag = nil)
    tag ||= DEFAULT_TAG
    tumblr_url = "#{API_URL}tag=#{tag}&api_key=#{API_KEY}"
    open(tumblr_url).read
  end

  def self.fetch_json(tag = nil)
    JSON.parse(fetch_raw(tag))
  end
end

# json = File.read('http://api.tumblr.com/v2/tagged?tag=fiddlercrabs&api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4') #wrong syntax


def show_json
  Tumblr.fetch_json
end

# def show
#   source = "http://api.tumblr.com/v2/tagged?tag=fiddlercrabs&api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"
#   data = JSON.parse(JSON.load(source))

# end

p show_json["response"][0]["image_permalink"]
p show_json["response"][0]["post_url"]
p show_json["response"][0]["caption"]





=begin
1) 'gem install tumblr_client'
2) 'gem install json'
3) Reference: https://github.com/fiddler-crabs-2014/ESA/blob/master/get_places.rb
4) https://github.com/fiddler-crabs-2014/ESA/blob/master/inserter.rb
5) https://github.com/tumblr/tumblr_client
url
picture
content

=end





