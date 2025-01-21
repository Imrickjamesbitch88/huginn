require_relative '../lib/character_response_filter'

class TwitterResponseTest
  def initialize
    @filter = CharacterResponseFilter.new
  end

  def run_test(scenario, input, context = {})
    puts "\n=== Testing: #{scenario} ==="
    puts "Input: #{input}"
    puts "Context: #{context.inspect}"
    response = @filter.character_response(input, context)
    puts "Response: #{response}"
    puts "Length: #{response.length} characters"
    puts "=" * 80
  end

  def run_all_tests
    puts "\n=== MAIGA Twitter Response Tests ===\n"

    # Viral Tweet Tests
    run_test("Viral Tweet", "This tweet got 100k likes!", {
      type: :viral,
      metrics: {
        likes: 100000,
        retweets: 50000
      }
    })

    # Quote Tweet Tests
    run_test("Quote Tweet", "RT @someone: TREMENDOUS insight about AI!", {
      type: :quote,
      original_author: "@someone"
    })

    # Thread Response Tests
    run_test("Thread", "HUGE THREAD 🧵 about the future of AI (1/14)", {
      type: :thread,
      position: 1,
      total: 14
    })

    # Breaking News Tests
    run_test("Breaking News", "BREAKING: Major AI breakthrough announced!", {
      type: :breaking,
      category: "tech"
    })

    # Ratio Response Tests
    run_test("Ratio", "Getting ratio'd by MAIGATRON is quantum karma!", {
      type: :ratio,
      ratio_metrics: {
        parent_likes: 100,
        response_likes: 1000
      }
    })

    # Mixed Context Tests
    run_test("Viral Thread", "This AI thread got 50k retweets! 🧵", {
      type: [:viral, :thread],
      metrics: {
        retweets: 50000
      }
    })

    # Team Interaction Tests
    run_test("Team Quote", "RT @JOE_RONIN: The quantum realm is speaking!", {
      type: :quote,
      team_member: "JOE_RONIN"
    })

    puts "\nAll Twitter response tests completed!"
  end
end

# Run the tests
puts "Starting MAIGA Twitter Response Tests..."
tester = TwitterResponseTest.new
tester.run_all_tests 