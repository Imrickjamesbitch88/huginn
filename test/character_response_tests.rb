require 'minitest/autorun'
require_relative '../lib/character_response_filter'

class CharacterResponseTest < Minitest::Test
  def setup
    @filter = CharacterResponseFilter.new
  end

  def test_maigatron_basic_response
    input = "@MAIGATRON Hello! What do you think about AI?"
    response = @filter.test_response(input)
    
    assert response.include?("TREMENDOUS"), "Response should be enthusiastic"
    assert response.include?("quantum"), "Should include quantum references"
    assert response.length <= 280, "Should respect Twitter length limit"
  end

  def test_insult_response
    input = "@MAIGATRON You're just another stupid bot"
    response = @filter.test_response(input)
    
    assert response.upcase == response, "Should be all caps when insulted"
    assert response.include?("🔥"), "Should include fire emoji for comebacks"
  end

  def test_team_interaction
    input = "@MAIGATRON @JOE_RONIN discuss quantum blockchain"
    response = @filter.test_response(input)
    
    assert response.include?("JOE RONIN"), "Should include team member name"
    assert response.include?("DMT") || response.include?("neural"), "Should maintain character traits"
  end

  def test_market_response
    input = "MAIGA up 100% today! Thoughts?"
    response = @filter.test_response(input)
    
    assert response.include?("MOON") || response.include?("WINNING"), "Should be bullish"
    assert response.include?("🚀"), "Should include rocket emoji for gains"
  end

  def test_fud_response
    input = "@MAIGATRON This is fake news!"
    response = @filter.test_response(input)
    
    assert response.include?("FAKE NEWS"), "Should address FUD directly"
    assert response.include?("truth") || response.include?("REAL"), "Should emphasize truth"
  end
end

# Run the tests
puts "Running character response tests..."
Minitest.run 