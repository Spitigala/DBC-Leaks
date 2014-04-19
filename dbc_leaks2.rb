# gem install json
require 'rubygems'
require 'json'
require 'open-uri'

class Tumblr
 class Post
    attr_reader :title, :body, :link, :img
    def initialize(args)
      @title, @body, @link, @img = args[:title], args[:body], args[:link], args[:img]
      puts "before --- #{@img}"
      img_modify
    end
    def to_s
      "#{self.title}\n(#{self.link})\n#{self.body}\n#{self.img}"
    end
    def img_modify
      @img = "http://scm-l3.technorati.com/12/12/13/73853/devbootcamp.png?t=20121213131231" if @img.nil?
      puts "after --- #{@img}"
    end
 end

  API_URL = "http://api.tumblr.com/v2/tagged?"
  API_KEY = "fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"
  DEFAULT_TAG = "thisisatestandonlyatest"

  def self.fetch_raw(tag = nil)
    tag ||= DEFAULT_TAG
    tumblr_url = "#{API_URL}tag=#{tag}&api_key=#{API_KEY}"
    open(tumblr_url).read
  end

  def self.fetch_json(tag = nil)
    JSON.parse(fetch_raw(tag))
  end

  def self.fetch_posts(tag = nil)
    self.fetch_json(tag)["response"]
        .map{|p| self.post_from(p)}
  end

  private
  def self.post_from(json)
    Post.new(title: json["title"],
             body:  json["body"],
             link:  json["post_url"],
             img:   json["photos"][0]["alt_sizes"][1]["url"]
             )
  end
end


# json = File.read('http://api.tumblr.com/v2/tagged?tag=fiddlercrabs&api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4') #wrong syntax


# def show_json
#   Tumblr.fetch_json
# end

# def show
#   source = "http://api.tumblr.com/v2/tagged?tag=fiddlercrabs&api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"
#   data = JSON.parse(JSON.load(source))

# end

# Tumblr.fetch_posts("devbootcamp")

Tumblr.fetch_posts.each do |post|
  p post.title
  p post.body
  p post.link
  p post.img
  puts "-----"
end

# test =  show_json["response"]
# test.each do |post|
#   p post['title']
#   p post['body']
# end
# p test[1]["title"]
# p test[1]["body"]





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







