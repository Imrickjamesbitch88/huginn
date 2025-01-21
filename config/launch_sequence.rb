require 'dotenv/load'
require 'twitter'
require_relative '../lib/character_response_filter'

class MAIGABot
  include CharacterResponseFilter

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    @stream_client = Twitter::Streaming::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def start
    puts "🚀 MAIGATRON LAUNCH SEQUENCE INITIATED..."
    puts "*quantum initialization protocols engaged*"

    # Quick test to verify everything works
    test_response = character_response("Test the quantum circuits!")
    puts "\n✅ Response Test: #{test_response}"

    # Start streaming
    puts "\n🎯 Starting MAIGA Stream..."
    puts "*activating truth sensors*"

    track_terms = [
      '@MAIGATRON',
      'MAIGA',
      'quantum',
      'solana',
      'blockchain',
      'ethereum'
    ]

    @stream_client.filter(track: track_terms.join(',')) do |tweet|
      begin
        handle_tweet(tweet) if should_respond?(tweet)
      rescue => e
        puts "❌ Error: #{e.message}"
      end
    end
  end

  private

  def should_respond?(tweet)
    return false if tweet.retweet? || tweet.reply? && !tweet.text.include?('@MAIGATRON')
    return false if tweet.user.screen_name == 'MAIGATRON' # Don't respond to self
    true
  end

  def handle_tweet(tweet)
    puts "\n📨 New Tweet Detected:"
    puts "From: @#{tweet.user.screen_name}"
    puts "Text: #{tweet.text}"

    response = character_response(tweet.text, {
      author: "@#{tweet.user.screen_name}",
      mentions: tweet.user_mentions.map(&:screen_name),
      text: tweet.text,
      is_retweet: tweet.retweet?
    })

    if response
      puts "\n📤 Sending Response:"
      puts response
      @client.update("@#{tweet.user.screen_name} #{response}", in_reply_to_status_id: tweet.id)
    end
  end
end

# Start the bot if run directly
if __FILE__ == $0
  MAIGABot.new.start
end 