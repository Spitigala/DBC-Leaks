require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do 
	@dbc = "Hello world!"
	erb :home
end

get '/about' do
	erb :about
end

not_found do
  erb :not_found
end


class Tumblr
 class Post
    attr_reader :title, :body, :link, :img
    def initialize(args = {})
      @title, @body, @link, @img = args[:title], args[:body], args[:link], args[:img] ||= "http://scm-l3.technorati.com/12/12/13/73853/devbootcamp.png?t=20121213131231"
    end
    def to_s
      "#{self.title}\n(#{self.link})\n#{self.body}\n#{self.img}"
    end
 end

  API_URL = "http://api.tumblr.com/v2/tagged?"
  API_KEY = "fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"
  DEFAULT_TAG = "dbcnyc"

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
             link:  json["post_url"]#,
             # img:   json["photos"][0]["alt_sizes"][1]["url"]   ----- Only works for image posts, not text posts
             )
  end
end