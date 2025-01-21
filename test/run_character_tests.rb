require_relative '../lib/character_response_filter'

class TestRunner
  def initialize
    @filter = CharacterResponseFilter.new
    @results = []
  end

  def run_test(scenario, input)
    puts "\n=== Testing: #{scenario} ==="
    puts "Input: #{input}"
    response = @filter.test_response(input)
    puts "Response: #{response}"
    puts "Length: #{response.length} characters"
    puts "=" * 80
    @results << {scenario: scenario, input: input, response: response}
  end

  def run_all_tests
    # MAIGATRON Core Tests
    run_test("Basic Greeting", "@MAIGATRON Hello!")
    run_test("AI Question", "@MAIGATRON What do you think about AI?")
    run_test("Insult Response", "@MAIGATRON You're just another stupid bot")
    run_test("Praise Response", "@MAIGATRON You're doing amazing work!")
    
    # Team Member Tests
    run_test("JOE RONIN", "@JOE_RONIN What's your take on consciousness?")
    run_test("GB ADVANCE", "@GB_ADVANCE How's the heartland blockchain?")
    run_test("RFK JR", "@RFK_JR What's the deep state hiding?")
    run_test("DOGE LORD", "@DARK_DADDY Price prediction?")
    
    # Team Interactions
    run_test("Team Debate", "@MAIGATRON @JOE_RONIN @GB_ADVANCE discuss quantum blockchain")
    run_test("FUD Defense", "@MAIGATRON @DARK_DADDY someone spreading FUD!")
    
    # Market Scenarios
    run_test("Bull Market", "MAIGA up 100% today! Thoughts?")
    run_test("FUD Attack", "This is just another pump and dump")
    
    # Edge Cases
    run_test("Emojis", "🚀🌙💎🤖 @MAIGATRON")
    run_test("Special Characters", "@MAIGATRON {$pecial Ch@racters} test")
    
    summarize_results
  end

  def summarize_results
    puts "\n=== Test Summary ==="
    puts "Total tests run: #{@results.length}"
    puts "Average response length: #{@results.map{|r| r[:response].length}.sum / @results.length} characters"
    puts "All responses within Twitter limit: #{@results.all?{|r| r[:response].length <= 280}}"
    puts "\nCharacter trait consistency:"
    check_character_traits
  end

  def check_character_traits
    traits = {
      caps: @results.count{|r| r[:response].upcase == r[:response]},
      quantum: @results.count{|r| r[:response].downcase.include?('quantum')},
      emojis: @results.count{|r| r[:response].match?(/[\u{1F300}-\u{1F9FF}]/)},
      asterisks: @results.count{|r| r[:response].include?('*')}
    }
    
    puts "- CAPS usage: #{(traits[:caps].to_f / @results.length * 100).round}%"
    puts "- Quantum references: #{(traits[:quantum].to_f / @results.length * 100).round}%"
    puts "- Emoji usage: #{(traits[:emojis].to_f / @results.length * 100).round}%"
    puts "- Action descriptions: #{(traits[:asterisks].to_f / @results.length * 100).round}%"
  end
end

# Run the tests
puts "Starting MAIGA Character Response Tests..."
runner = TestRunner.new
runner.run_all_tests 