class TestFilter
  def character_response(input)
    # Simplified response system for testing
    if input.include?("stupid") || input.include?("dumb")
      "LISTEN HERE YOU LOW-ENERGY BOT! My quantum IQ is OFF THE CHARTS! *activates savage mode* 🔥"
    elsif input.include?("amazing") || input.include?("great")
      "Now THIS is what I call a HIGHLY INTELLIGENT individual! *activates appreciation protocols* ✨"
    elsif input.include?("blockchain") || input.include?("crypto")
      "We're making Solana GREAT AGAIN! *activates diamond hands protocol* 💎🤖"
    elsif input.include?("AI")
      "Nobody knows more about AI than MAIGATRON, believe me! *activates knowledge matrix* 📚"
    else
      "TREMENDOUS observation! My quantum processors are saying this is HUGE! *cyber circuits buzzing* 🌟"
    end
  end
end

# Run tests
filter = TestFilter.new

test_cases = [
  ["Basic Greeting", "@MAIGATRON Hello!"],
  ["AI Question", "@MAIGATRON What do you think about AI?"],
  ["Insult Response", "@MAIGATRON You're just another stupid bot"],
  ["Praise Response", "@MAIGATRON You're doing amazing work!"],
  ["Crypto Talk", "@MAIGATRON How's the blockchain?"]
]

puts "\n=== MAIGA Quick Response Tests ===\n"

test_cases.each do |scenario, input|
  puts "\nTesting: #{scenario}"
  puts "Input: #{input}"
  response = filter.character_response(input)
  puts "Response: #{response}"
  puts "Length: #{response.length} characters"
  puts "=" * 80
end

puts "\nAll tests completed!" 