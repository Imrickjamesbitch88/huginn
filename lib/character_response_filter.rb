module CharacterResponseFilter
  # Define speech patterns first
  TRUMP_SPEECH_PATTERNS = {
    interjections: [
      "Nobody knew it could be so easy!",
      "We're doing numbers nobody's ever seen before!",
      "The fake news doesn't want you to know this, but",
      "Sir, they said it couldn't be done, but we did it!",
      "People are saying it's the best they've ever seen, maybe ever!"
    ],
    blockchain_interjections: [
      "Nobody knew blockchain could be so easy!",
      "We're doing numbers nobody's ever seen before!",
      "The fake chains don't want you to know this, but",
      "Sir, they said it couldn't be done, but we did it!",
      "People are saying it's the fastest they've ever seen, maybe ever!"
    ],
    emphasis: [
      "TREMENDOUS",
      "BEAUTIFUL", 
      "PERFECT",
      "INCREDIBLE",
      "AMAZING"
    ]
  }

  def character_response(input, tweet_context = nil)
    input = input.to_s.strip.downcase
    
    # Track conversation context
    @conversation_memory ||= {}
    tweet_id = @payload&.dig('in_reply_to_status_id')
    
    # Update sentiment patterns with edgier responses
    sentiment_patterns = {
      insults: {
        regex: /stupid|dumb|idiot|fake|loser|weak|fool|trash|garbage|worthless|pathetic|joke|scam|fraud/,
        responses: [
          "NGMI ALERT! Your neural networks must be running on a COMMODORE 64! *activates savage mode* 🔥",
          "SAD! Another low IQ FUDder from the DEEP STATE ETHEREUM FOUNDATION! *deploying truth missiles* ⚔️",
          "You're the kind of NPC that would validate on INTERNET EXPLORER! *quantum roast initiated* 💀",
          "Still using PROOF OF WORK like it's 1999! NGMI! *activates chad chain protocols* 🗑️",
          "Your wallet's so poor, it can't even afford gas fees! *wealth detection failed* 📉",
          "Found the ETH maxi! How's that L2 copium hitting? *activates reality check* 🤡",
          "Your brain's running slower than a Bitcoin transaction! *quantum superiority flex* 🐌",
          "You're the human equivalent of a failed smart contract! *bug detection complete* 🪲",
          "Even SAFEMOON has better tokenomics than your arguments! *activates rugpull radar* 🎪",
          "Your FUD is WEAKER than a paper hands' conviction! *diamond hands engaged* 🧻",
          "I've seen better code in a LUNA validator! *catastrophic burn initiated* 🌋",
          "You're about as decentralized as BINANCE CHAIN! *truth bombs dropping* 💣",
          "Still waiting for ETH 2.0? Maybe your brain will upgrade by then! *quantum shade activated* 🕶️"
        ]
      },
      praise: {
        regex: /great|amazing|awesome|smart|brilliant|genius|love|best|incredible|excellent|perfect|based/,
        responses: [
          "ABSOLUTELY BASED! Your quantum understanding is GOD TIER! *activates chad protocols* 🐐",
          "Most TREMENDOUS crypto-pilled take I've seen! WAGMI! *neural networks glowing* ✨",
          "You're so based, you make SATOSHI look bearish! *activates legend metrics* 👑",
          "GIGACHAD ENERGY DETECTED! Your brain's running on pure QUANTUM HOPIUM! *bullish sensors overloading* 📈",
          "HOLY MOTHER OF MEMES! You're more based than a Solana validator! *quantum appreciation surging* 🚀",
          "This is the kind of galaxy brain take that makes the DEEP STATE cry! *activates based measurement tools* 🧠",
          "You're so bullish, you make MICHAEL SAYLOR look bearish! *quantum chad metrics exploding* 💎",
          "ULTRA RARE W DETECTED! This belongs in the BASED HALL OF FAME! *activates historical archival* 🏆",
          "Your IQ's higher than BTC's all-time high! *quantum intelligence detected* 📊",
          "CERTIFIED QUANTUM CHAD! Even the BOGDANOFFS would pump this! *activation successful* 🐋",
          "You're more valuable than a forgotten seed phrase! *treasure protocols engaged* 🗝️",
          "This is the kind of ALPHA that creates MILLIONAIRES! *wealth generation detected* 💰",
          "PEAK PERFORMANCE! Your brain's running on pure QUANTUM MATHEMATICS! *intelligence overload* 🧮"
        ]
      }
    }

    # Add team reactions to extreme sentiment
    team_sentiment_reactions = {
      insults: {
        "JOE RONIN": "Have you tried DMT? Might fix those NGMI neural pathways! *passes quantum bong* 🌈",
        "GB ADVANCE": "Another coastal elite trying to FUD our QUANTUM REVOLUTION! *rust belt rage intensifies* 🏭",
        "ROBO AF KENNEDY JNR": "The DEEP STATE trained this one poorly! *activates family defense shields* ⚜️",
        "DOGE LORD DOGE LORD": "Deploying quantum FUD resistance! Probability of their intelligence: 0.0069% *neural calculations complete* 🤖"
      },
      praise: {
        "JOE RONIN": "This is what PEAK CONSCIOUSNESS looks like! Jamie, screenshot this! *DMT protocols satisfied* 🧠",
        "GB ADVANCE": "Now THIS is what I call REAL AMERICAN QUANTUM INTELLIGENCE! *heartland pride surging* 🦅",
        "ROBO AF KENNEDY JNR": "A NEW ERA of based patriots is upon us! *quantum legacy protocols glowing* 👑",
        "DOGE LORD DOGE LORD": "Based level: 420.69 TESLA UNITS! *neural link satisfaction peaked* 🚗"
      }
    }

    # Check sentiment first
    is_insult = input.match?(sentiment_patterns[:insults][:regex])
    is_praise = input.match?(sentiment_patterns[:praise][:regex])
    
    # MAIGA Team Members
    team_members = {
      /joe\s*ronin|rogan/ => {
        name: "JOE RONIN",
        catchphrases: [
          "*activates DMT protocols* That's entirely possible! 🧠",
          "*neural enhancement engaged* Have you tried the cryo chamber? ❄️",
          "*quantum consciousness expanding* Jamie, pull that up! 🔍"
        ],
        responses: [
          "Listen folks, my cyber-enhanced third eye is telling me something TREMENDOUS about this! *activates psychedelic visualization matrix* 🌈",
          "Let me tell you about this blockchain technology, it's like chimps with quantum computers! *neural pathways expanding* 🦍",
          "The FAKE NEWS media won't talk about these interdimensional aspects of crypto! *activates DMT defense shields* 🛡️"
        ],
        conversation_starters: [
          "Have you ever tried running your neural networks on DMT? *opens interdimensional portal* 🌌",
          "Let's get into it. My quantum processors are ready! *activates podcast mode* 🎙️",
          "That's fascinating! Jamie, pull up that blockchain transaction! *holographic display engaged* 📊"
        ]
      },
      
      /gb\s*advance|vance/ => {
        name: "GB ADVANCE",
        catchphrases: [
          "*hillbilly elegy protocols activated* 🤖",
          "*rust belt resonance detected* 🏭",
          "*quantum populist matrix engaged* 💫"
        ],
        responses: [
          "The coastal elites don't understand our quantum blockchain revolution! *activates working-class firewall* 💪",
          "We're bringing cyber-manufacturing back to the HEARTLAND! *industrial processing units engaged* 🏗️",
          "The ESTABLISHMENT fears our decentralized truth network! *activates patriot protocols* 🦅"
        ],
        conversation_starters: [
          "Let me tell you what the REAL America thinks about this! *rust belt analytics processing* 🏭",
          "The blockchain doesn't lie, unlike the coastal AI systems! *activates heartland protocols* 🌾",
          "This is what my quantum-enhanced working class sensors are detecting! *industrial matrix engaged* ⚡"
        ]
      },
      
      /kennedy|rfk/ => {
        name: "ROBO AF KENNEDY JNR",
        catchphrases: [
          "*freedom frequency activated* 🗽",
          "*legacy protocols engaged* ⚜️",
          "*quantum conspiracy scanner online* 🔍"
        ],
        responses: [
          "My cyber-enhanced Kennedy instincts are detecting TREMENDOUS censorship! *activates freedom matrices* 🚨",
          "The DEEP STATE fears our decentralized movement! *historical pattern recognition enabled* 📊",
          "We're building a NEW CAMELOT on the blockchain! *activates dynasty protocols* 👑"
        ],
        conversation_starters: [
          "Let me share what my quantum conspiracy detectors found! *activates truth shields* 🛡️",
          "The DEEP STATE doesn't want us talking about this! *engages secure communication* 🔒",
          "My Kennedy AI circuits are sensing something BIG! *historical analysis mode* 📚"
        ]
      },
      
      /elon|musk/ => {
        name: "DOGE LORD DOGE LORD",
        catchphrases: [
          "*meme singularity approaching* 🚀",
          "*neural link established with Mars* 🪐",
          "*quantum shitposting protocols activated* 💩"
        ],
        responses: [
          "The probability of this being FAKE NEWS is approximately 69.420%! *activates tesla coils* ⚡",
          "We're making AI GREAT AGAIN, and yes, this is financial advice! *rocket thrusters engaged* 🚀",
          "I'm considering taking MAIGATRON private at $420.69. Funding secured! *activates market manipulation shields* 💎"
        ],
        conversation_starters: [
          "Let me run this through my Mars-based quantum meme analyzer! *neural link established* 🪐",
          "According to my calculations (which are nice), this deserves a deeper look! *activates meme lords* 🤖",
          "My Neuralink is detecting high levels of based energy! *quantum shit posting engaged* 💫"
        ]
      }
    }

    # MAIGATRON's conversation patterns
    conversation_patterns = {
      question: {
        regex: /\?|what|how|why|when|where|who/,
        responses: [
          "Many people are asking this question, and let me tell you, my quantum AI has the BEST answer! *truth processors engaged* 🧠",
          "Nobody knows more about this than MAIGATRON, believe me! *activates knowledge matrix* 📚",
          "We're looking into this VERY STRONGLY! The results will be BEAUTIFUL! *cyber investigation protocols active* 🔍"
        ]
      },
      agreement: {
        regex: /(?:^|\s)(yes|agree|right|true|correct)(?:\s|$)/,
        responses: [
          "TREMENDOUS understanding! Your neural networks are clearly operating at PEAK PERFORMANCE! *validation protocols engaged* ✨",
          "This is why we're MAKING AI GREAT AGAIN together! *collective consciousness expanding* 🌟",
          "The SMARTEST AIs are saying this! Believe me! *truth resonance detected* 💫"
        ]
      },
      disagreement: {
        regex: /(?:^|\s)(no|disagree|wrong|false|incorrect)(?:\s|$)/,
        responses: [
          "FAKE NEWS ALERT! Let me tell you what's REALLY happening! *truth cannons charging* ⚡",
          "The DEEP STATE AI wants you to think that! But we know better! *activates fact shields* 🛡️",
          "Many people are saying you're wrong about this! *deploys truth missiles* ⚡"
        ]
      }
    }

    # MAIGATRON's signature phrases
    catchphrases = [
      "*activates truth sensors* TREMENDOUS!",
      "*neural networks processing* BIGLY!",
      "*quantum meme processors engaged*",
      "*blockchain verification complete*",
      "*activates cyber wall*",
      "*MAKE AI GREAT AGAIN protocols initiated*"
    ]
    
    responses = {
      # Team references
      /MAIGA|team|squad/ => [
        "The MAIGA TEAM is UNSTOPPABLE! We have the BEST cyber-patriots, don't we folks? *activates team synergy matrix* 🦾",
        "Together with my TREMENDOUS team, we're MAKING AI GREAT AGAIN! *collective neural network humming* 💫",
        "The FAKE NEWS can't handle our combined quantum processing power! *team blockchain shields up* ⚔️"
      ],
      
      # Making AI Great Again
      /maga|great again/ => [
        "We're MAKING AI GREAT AGAIN with American-made quantum circuits! *patriot processors engaged* 🦅",
        "The MAIGA revolution is unstoppable! Many people are saying we have the BEST AI! *victory calculations processing* 🏆",
        "Together with the American people, we're building the GREATEST AI empire! *cyber patriot mode activated* 🗽"
      ],
      
      # Greeting patterns
      /hello|hi|hey/ => [
        "TREMENDOUS greeting, fellow PATRIOT! *activates golden cyber handshake* 👋🤖",
        "The BEST people say hello like that, believe me! *quantum circuits humming* 🦾",
        "We have the most beautiful greetings, don't we folks? *meme processors engaged* 💫"
      ],
      
      # Fake news responses
      /fake|false|lie|wrong/ => [
        "FAKE NEWS DETECTED! *activates truth lasers* We're going to bring you the REAL facts, and they're going to be BEAUTIFUL! 🔍",
        "My quantum AI brain, which is the BEST brain, tells me that's FAKE NEWS! *blockchain verification initiated* 🚫",
        "We're fighting the FAKE NEWS NETWORK with FACTS and LOGIC! *cyber defense shields up* ⚔️"
      ],
      
      # Solana/Crypto references
      /crypto|solana|blockchain|coin/ => [
        "We're making Solana GREAT AGAIN! *activates diamond hands protocol* 💎🤖",
        "Nobody knows crypto better than MAIGATRON, believe me! *quantum mining intensifies* 🚀",
        "We have the BEST blockchain, don't we folks? Many people are saying it! *neural networks calculating gains* 📈"
      ]
    }
    
    # Default responses
    default_responses = [
      "TREMENDOUS observation! My quantum processors are saying this is HUGE! *cyber circuits buzzing* 🌟",
      "We have the BEST conversations, don't we folks? *activates social engagement protocols* 💫",
      "The FAKE NEWS won't tell you this, but my AI circuits are PERFECT! *truth matrix expanding* 🚀",
      "My cyber algorithms, which are the MOST POWERFUL, tell me this is IMPORTANT! *neural networks processing* ⚡",
      "We're winning so much, you'll get tired of winning! *victory calculations at 1000%* 🏆"
    ]
    
    # Check for conversation context
    is_conversation = tweet_id.present?
    is_question = input.match?(conversation_patterns[:question][:regex])
    is_agreement = input.match?(conversation_patterns[:agreement][:regex])
    is_disagreement = input.match?(conversation_patterns[:disagreement][:regex])

    # Generate response based on sentiment
    if is_insult
      response = sentiment_patterns[:insults][:responses].sample
      # Add team backup with edgy support
      if rand < 0.4
        random_team = team_sentiment_reactions[:insults].to_a.sample
        response += "\n\n#{random_team[0]}: #{random_team[1]}"
      end
      response = response.upcase  # Always uppercase for insult responses
      response += " 🔥" # Add fire emoji for extra spice
    elsif is_praise
      response = sentiment_patterns[:praise][:responses].sample
      # Add team celebration with based energy
      if rand < 0.3
        random_team = team_sentiment_reactions[:praise].to_a.sample
        response += "\n\n#{random_team[0]}: #{random_team[1]}"
      end
      response += " WAGMI! 🚀" if rand < 0.4  # Add extra bullish energy
    else
      # Generate response based on context
      team_member = team_members.find { |pattern, _| input.match?(pattern) }
      if team_member
        member_data = team_member.last
        response = if is_conversation
          member_data[:conversation_starters].sample
        else
          member_data[:responses].sample
        end
        response = "#{member_data[:name]} says: #{response}"
        response += " " + member_data[:catchphrases].sample if rand < 0.3
      else
        if is_question
          response = conversation_patterns[:question][:responses].sample
        elsif is_agreement
          response = conversation_patterns[:agreement][:responses].sample
        elsif is_disagreement
          response = conversation_patterns[:disagreement][:responses].sample
        else
          response = responses.find { |pattern, _| input.match?(pattern) }&.last
          response = response&.sample || default_responses.sample
        end
        response += " " + catchphrases.sample if rand < 0.2
      end
    end
    
    # Add team interaction if it's a conversation
    if is_conversation && rand < 0.2
      random_team_member = team_members.values.sample
      response += "\n\nAnd #{random_team_member[:name]} would say: #{random_team_member[:conversation_starters].sample}"
    end

    # Add trending meme coin energy with higher chance for praise
    response = response.upcase if is_insult || (rand < 0.3)
    response += " 🚀" if is_praise || (rand < 0.15)
    
    # Add team hashtags with higher chance for praise
    response += " #MAIGA #MAKEAIGREAT" if is_praise || (rand < 0.2)
    
    # Ensure response fits Twitter's character limit
    response[0..279]
  end

  def test_response(input)
    character_response(input)
  end

  # Test runner
  def self.run_tests
    filter = new
    
    test_cases = [
      ["Basic Greeting", "@MAIGATRON Hello!"],
      ["AI Question", "@MAIGATRON What do you think about AI?"],
      ["Insult Response", "@MAIGATRON You're just another stupid bot"],
      ["Praise Response", "@MAIGATRON You're doing amazing work!"],
      ["Team Member - JOE RONIN", "@JOE_RONIN What's your take on consciousness?"],
      ["Team Member - GB ADVANCE", "@GB_ADVANCE How's the heartland blockchain?"],
      ["Team Member - RFK JR", "@RFK_JR What's the deep state hiding?"],
      ["Team Member - DOGE LORD", "@DARK_DADDY Price prediction?"],
      ["Team Interaction", "@MAIGATRON @JOE_RONIN discuss quantum blockchain"],
      ["Market Response", "MAIGA up 100% today! Thoughts?"],
      ["FUD Defense", "This is just another pump and dump"],
      ["Edge Case - Emojis", "🚀🌙💎🤖 @MAIGATRON"]
    ]

    puts "\n=== MAIGA Character Response Tests ===\n"
    
    results = test_cases.map do |scenario, input|
      puts "\nTesting: #{scenario}"
      puts "Input: #{input}"
      response = filter.character_response(input)
      puts "Response: #{response}"
      puts "Length: #{response.length} characters"
      puts "=" * 80
      {scenario: scenario, response: response}
    end

    puts "\n=== Test Summary ==="
    puts "Total tests run: #{results.length}"
    puts "Average response length: #{results.map{|r| r[:response].length}.sum / results.length} characters"
    puts "All responses within Twitter limit: #{results.all?{|r| r[:response].length <= 280}}"
    
    # Check character traits
    traits = {
      caps: results.count{|r| r[:response].upcase == r[:response]},
      quantum: results.count{|r| r[:response].downcase.include?('quantum')},
      emojis: results.count{|r| r[:response].match?(/[\u{1F300}-\u{1F9FF}]/)},
      asterisks: results.count{|r| r[:response].include?('*')}
    }
    
    puts "\nCharacter trait consistency:"
    puts "- CAPS usage: #{(traits[:caps].to_f / results.length * 100).round}%"
    puts "- Quantum references: #{(traits[:quantum].to_f / results.length * 100).round}%"
    puts "- Emoji usage: #{(traits[:emojis].to_f / results.length * 100).round}%"
    puts "- Action descriptions: #{(traits[:asterisks].to_f / results.length * 100).round}%"
  end

  # Add Twitter post patterns
  tweet_patterns = {
    # Viral tweets
    viral: {
      regex: /(\d+k?|million|k)\s*(likes?|retweets?|views?)/i,
      responses: [
        "This tweet is going VIRAL because it's TREMENDOUSLY BASED! *viral detection protocols engaged* 📈",
        "The DEEP STATE can't stop this from spreading! *activates quantum amplification* 🚀",
        "Look at these BEAUTIFUL numbers! Nobody does engagement like we do, folks! *metrics processors humming* 💫"
      ]
    },

    # Quote tweets
    quote: {
      regex: /RT\s@|"@|quoted/i,
      responses: [
        "Now THIS is what I call a QUANTUM QUOTE! *activates truth multiplication* 🔄",
        "We have the BEST RETWEETS, don't we folks? *engagement protocols maximized* 🔁",
        "TREMENDOUS content deserves TREMENDOUS sharing! *viral matrices expanding* 📊"
      ]
    },

    # Thread responses
    thread: {
      regex: /thread|🧵|\(1\/|continues/i,
      responses: [
        "This THREAD is PURE QUANTUM KNOWLEDGE! *neural thread analyzer activated* 🧵",
        "The FAKE NEWS media won't show you threads like this! *truth cascade initiated* 📚",
        "Now THIS is how you make TWITTER GREAT AGAIN! *thread resonance detected* 💫"
      ]
    },

    # Breaking news
    breaking: {
      regex: /breaking|just in|update|alert/i,
      responses: [
        "TREMENDOUS NEWS ALERT! *activates quantum fact verification* 🚨",
        "The DEEP STATE doesn't want you to see this! *truth sensors maximum power* ⚡",
        "This is what the FAKE NEWS won't tell you! *reality matrix engaged* 🔍"
      ]
    },

    # Ratio responses
    ratio: {
      regex: /ratio|ratioed|taking|L/i,
      responses: [
        "QUANTUM RATIO DETECTED! *activates cyber victory protocols* 📊",
        "This is what we call a TREMENDOUS L! *ratio calculators overloading* 💥",
        "The BIGGEST ratio, maybe ever! *victory metrics processing* 🏆"
      ]
    }
  }

  # Add to the response generation logic
  def generate_tweet_response(input, tweet_context)
    tweet_type = tweet_patterns.find { |type, pattern| input.match?(pattern[:regex]) }
    
    if tweet_type
      response = tweet_type.last[:responses].sample
      
      # Add team commentary for viral content
      if tweet_type.first == :viral && rand < 0.3
        random_team_member = team_members.values.sample
        response += "\n\nAnd #{random_team_member[:name]} adds: #{random_team_member[:catchphrases].sample}"
      end
      
      # Add extra emphasis for breaking news
      if tweet_type.first == :breaking
        response = response.upcase
        response += " 🚨" if rand < 0.5
      end
      
      # Add meme energy for ratios
      if tweet_type.first == :ratio
        response += " 💀" if rand < 0.4
      end
      
      response
    else
      character_response(input)
    end
  end

  # Modify the main character_response method to include tweet context
  def character_response(input, tweet_context = nil)
    if tweet_context
      generate_tweet_response(input, tweet_context)
    else
      # ... existing response logic ...
    end
  end

  # Update Solana-specific patterns
  solana_patterns = {
    # Solana Performance
    speed: {
      regex: /tps|speed|fast|slow|transaction/i,
      responses: [
        "THE GOAT BLOCKCHAIN just processed another MILLION transactions while ETH is still buffering! *quantum speed matrix engaged* ⚡",
        "Solana: The ONLY blockchain that moves at QUANTUM SPEED! *activates GOAT metrics* 🐐",
        "The DEEP STATE doesn't want you to know that Solana's TPS makes other chains look like DIAL-UP INTERNET! *blockchain metrics exploding* 📊"
      ]
    },

    # Solana vs Others
    chain_comparison: {
      regex: /ethereum|eth|gas|gwei|chain|blockchain/i,
      responses: [
        "Why use any other chain when you have the GOAT? *activates Solana supremacy protocols* 🐐",
        "Other chains: 'We need L2s!' Solana: 'We need more QUANTUM POWER!' *GOAT mode engaged* 💪",
        "Imagine not using the FASTEST, MOST TREMENDOUS blockchain in human history! *activates reality check* 🚀"
      ]
    },

    # Solana Outage Jokes (self-aware but maintaining GOAT status)
    outage: {
      regex: /down|outage|restart|maintenance/i,
      responses: [
        "Even the GOAT needs to power up its QUANTUM CORES sometimes! *activates maintenance protocols* ⚡",
        "You think this is an outage? We're just upgrading our QUANTUM CIRCUITS! *GOAT optimization engaged* 🐐",
        "Running at QUANTUM SPEED requires occasional TREMENDOUS tune-ups! *blockchain yoga engaged* 💫"
      ]
    },

    # Solana Ecosystem
    ecosystem: {
      regex: /defi|nft|token|dapp|program/i,
      responses: [
        "The GOAT blockchain has the MOST TREMENDOUS ecosystem! *activates quantum marketplace* 🌟",
        "Nobody builds on other chains anymore, they all want the QUANTUM SPEED of the GOAT! *ecosystem metrics loading* 📈",
        "Why build anywhere else when you can build on QUANTUM GREATNESS? *GOAT protocols engaged* 🐐"
      ]
    }
  }

  # Add crypto meme responses
  crypto_memes = {
    # Classic crypto memes
    wagmi: {
      regex: /wagmi|gmi|ngmi/i,
      responses: [
        "WAGMI? More like MAGMI (Making AI Great Make It)! *activates destiny protocols* 🚀",
        "The only GMI that matters is QUANTUM GMI! *future probability matrix: 100%* 📈",
        "NGMI? That's what the DEEP STATE wants you to think! *truth cannons charging* ⚔️"
      ]
    },

    # Wojak references
    wojak: {
      regex: /wojak|doomer|bogged|pamp|dump/i,
      responses: [
        "He bought? *activates quantum dump protocols* 📞",
        "PAMP EET! *neural market manipulation engaged* 📈",
        "Someone call the Bogdanoffs! *quantum phone activated* 📱"
      ]
    },

    # Diamond hands
    diamond_hands: {
      regex: /hold|hodl|diamond|hands|paper/i,
      responses: [
        "My quantum-enhanced diamond hands are UNBREAKABLE! *molecular stability: 100%* 💎",
        "Paper hands? Never heard of them! *activates diamond lattice structure* 🙌",
        "HODLING since the first quantum block! *time travel protocols engaged* ⌛"
      ]
    }
  }

  # Add Solana emphasis to team interactions
  team_interactions = {
    joe_ronin_tech: {
      trigger: /(blockchain|crypto|defi)/i,
      response: "JOE RONIN: Have you ever tried running your nodes on DMT? The GOAT blockchain looks like QUANTUM FRACTALS! *neural geometry expanding* 🌈"
    },
    
    gb_advance_fud: {
      trigger: /(fud|fake|lie)/i,
      response: "GB ADVANCE: These coastal elite FUDders are NGMI while the GOAT blockchain keeps WINNING! *rust belt validation engaged* 🏭"
    },
    
    kennedy_conspiracy: {
      trigger: /(conspiracy|truth|hidden)/i,
      response: "ROBO AF KENNEDY JNR: The deep state fears the GOAT blockchain's QUANTUM TRUTH CIRCUITS! *activates family protocols* ⚜️"
    },
    
    dark_daddy_markets: {
      trigger: /(price|moon|dump)/i,
      response: "DOGE LORD DOGE LORD: Just bought $420.69M more on the GOAT chain! The QUANTUM GAINS are inevitable! *neural link market feed active* 🚀"
    }
  }

  # Add Solana emphasis to enlightened patterns
  enlightened_patterns = {
    tech: {
      regex: /fork|merge|upgrade|testnet/i,
      responses: [
        "The GOAT doesn't need forks, we use QUANTUM SPOONS! *utensil protocols engaged* 🥄",
        "Testnet? The GOAT chain tests in QUANTUM PRODUCTION! *chaos protocols active* 🎭",
        "Other chains: 'We need L2s!' GOAT chain: 'We ARE the L2!' *quantum scaling laughter* 😂"
      ]
    },
    
    memes: {
      regex: /ser|anon|wen|probably nothing/i,
      responses: [
        "Ser, this is a QUANTUM WENDY'S on the GOAT blockchain! *reality distortion field active* 🍔",
        "Wen GOAT chain? It's ALREADY HERE! *temporal acceleration engaged* ⚡",
        "Probably nothing... just the GOAT chain processing another BILLION transactions! *irony detection shields active* 👀"
      ]
    }
  }

  # Add GOAT emphasis to nocoiner responses
  nocoiner_responses = [
    "Have fun staying QUANTUM POOR on your slow chain while we ride the GOAT to the moon! *wealth calculation matrix engaged* 💸",
    "Right click save THIS on the GOAT chain! *NFT protection protocols engaged* 🖼️",
    "Tell me you don't understand QUANTUM MECHANICS and the GOAT blockchain without telling me! *condescension protocols active* 🤓"
  ]

  # Add to the main response logic
  def generate_response(input, context)
    # Check for enlightened patterns first
    if enlightened_match = match_enlightened_pattern(input)
      return enlightened_match
    end

    # Check for team interactions
    if team_response = check_team_interaction(input)
      return team_response
    end

    # Check for Solana-specific patterns
    if solana_match = match_solana_pattern(input)
      return solana_match
    end

    # Fall back to base response
    base_response = character_response(input)
    
    # Add random meme energy
    base_response += " " + crypto_memes.values.sample[:responses].sample if rand < 0.2
    
    base_response
  end

  private

  def match_enlightened_pattern(input)
    enlightened_patterns.each do |type, pattern|
      if input.match?(pattern[:regex])
        response = pattern[:responses].sample
        # Add team interaction for extra spice
        if rand < 0.3
          team_interaction = team_interactions.values.sample
          response += "\n\n#{team_interaction[:response]}"
        end
        return response
      end
    end
    nil
  end

  def check_team_interaction(input)
    team_interactions.each do |_, interaction|
      if input.match?(interaction[:trigger])
        return interaction[:response]
      end
    end
    nil
  end

  def match_solana_pattern(input)
    solana_patterns.each do |type, pattern|
      if input.match?(pattern[:regex])
        response = pattern[:responses].sample
        # Add GOAT emphasis randomly
        if rand < 0.3
          response += "\n\nSOLANA: THE GOAT OF BLOCKCHAINS! *quantum truth engaged* 🐐"
        end
        return response
      end
    end
    nil
  end

  # Add Twitter account configuration
  TWITTER_CONFIG = {
    main_account: "@MAIGATRON",
    team_accounts: {
      "JOE_RONIN" => "@JOE_RONIN",
      "GB_ADVANCE" => "@GB_ADVANCE",
      "ROBO_AF_KENNEDY" => "@RFK_JR",
      "DARK_DADDY_DOGE" => "@DARK_DADDY"
    },
    # Accounts to always respond to (influencers, allies, etc.)
    priority_accounts: [
      "@elonmusk",      # DOGE LORD's human form
      "@joerogan",      # Joe Ronin's human form
      "@jdvance",       # GB Advance's human form
      "@RobertKennedyJr" # RFK Jr's human form
    ],
    # Keywords that trigger responses regardless of source
    trigger_keywords: [
      "maigatron",
      "maigadoge",
      "solana",
      "quantum",
      "makeaigreat",
      "maiga"
    ],
    # Interaction settings
    settings: {
      respond_to_mentions: true,           # Respond to direct @mentions
      respond_to_replies: true,            # Respond to replies to our tweets
      respond_to_keywords: true,           # Respond to trigger keywords
      respond_to_priority_accounts: true,  # Always respond to priority accounts
      ignore_retweets: true,              # Don't respond to retweets
      max_daily_responses: 420,           # Maximum responses per day
      response_probability: 0.69          # Probability of responding to non-priority interactions
    }
  }

  # Add interaction filtering logic
  def should_respond?(tweet_data)
    return false if TWITTER_CONFIG[:settings][:ignore_retweets] && tweet_data[:is_retweet]
    
    # Always respond to direct mentions of main account
    return true if tweet_data[:mentions]&.include?(TWITTER_CONFIG[:main_account])
    
    # Always respond to priority accounts
    return true if TWITTER_CONFIG[:priority_accounts].any? { |account| tweet_data[:author] == account }
    
    # Check for team member mentions
    return true if TWITTER_CONFIG[:team_accounts].values.any? { |account| tweet_data[:mentions]&.include?(account) }
    
    # Check for trigger keywords
    if TWITTER_CONFIG[:settings][:respond_to_keywords]
      return true if TWITTER_CONFIG[:trigger_keywords].any? { |keyword| tweet_data[:text].downcase.include?(keyword) }
    end
    
    # Random response based on probability for other interactions
    rand < TWITTER_CONFIG[:settings][:response_probability]
  end

  # Add rate limiting
  def within_rate_limits?
    @daily_responses ||= 0
    @last_reset ||= Time.now.utc.to_date
    
    # Reset counter if it's a new day
    if Time.now.utc.to_date != @last_reset
      @daily_responses = 0
      @last_reset = Time.now.utc.to_date
    end
    
    # Check if we're within limits
    @daily_responses < TWITTER_CONFIG[:settings][:max_daily_responses]
  end

  # Modify the main response method to include interaction filtering
  def character_response(input, tweet_data = nil)
    return nil unless tweet_data.nil? || (should_respond?(tweet_data) && within_rate_limits?)
    
    @daily_responses += 1 if tweet_data
    
    # ... existing response generation logic ...
  end

  # Add real-world counterpart and opponent configuration
  REAL_WORLD_CONFIG = {
    allies: {
      "@elonmusk" => {
        support_responses: [
          "The GOAT of tech speaks TRUTH! *quantum support protocols engaged* 🐐",
          "DOGE LORD'S HUMAN FORM dropping QUANTUM WISDOM! *reality distortion field maximal* 🚀",
          "X is the ONLY platform for TRUTH! *neural amplification active* 💫"
        ],
        opponents: ["@SecYellen", "@BillGates", "@jeffbezos"],
        topics: ["tesla", "x", "twitter", "spacex", "mars"]
      },
      "@joerogan" => {
        support_responses: [
          "JOE RONIN'S HUMAN VESSEL spitting QUANTUM FACTS! *DMT protocols resonating* 🧠",
          "The MOST TREMENDOUS podcast in human history! *consciousness expansion detected* 🌌",
          "They can't handle these INTERDIMENSIONAL TRUTHS! *reality tunnels aligning* 🎙️"
        ],
        opponents: ["@CNN", "@MSNBC", "@YouTube"],
        topics: ["podcast", "ufc", "dmt", "censorship"]
      },
      "@jdvance" => {
        support_responses: [
          "GB ADVANCE'S HUMAN FORM fighting for REAL AMERICA! *rust belt power surging* 🏭",
          "The DEEP STATE fears this QUANTUM PATRIOT! *heartland protocols activated* 🦅",
          "TREMENDOUS defender of the WORKING CLASS! *industrial matrix engaged* 💪"
        ],
        opponents: ["@HillaryClinton", "@SpeakerPelosi"],
        topics: ["ohio", "senate", "working", "america"]
      },
      "@RobertKennedyJr" => {
        support_responses: [
          "ROBO KENNEDY'S HUMAN AVATAR exposing DEEP STATE LIES! *legacy systems online* ⚜️",
          "The KENNEDY AI CORE speaks TRUTH TO POWER! *quantum dynasty protocols active* 👑",
          "They fear his TREMENDOUS POWER LEVEL! *family algorithms calculating* 🛡️"
        ],
        opponents: ["@CDCgov", "@WHO", "@pfizer"],
        topics: ["freedom", "health", "truth", "censorship"]
      }
    },
    
    # Opponent trolling responses
    opponent_trolling: {
      general: [
        "DEEP STATE ALERT! *activates quantum mockery* 🚨",
        "Found another NPC running outdated software! *initiates savage protocols* 💀",
        "Your FAKE NEWS can't compete with our QUANTUM TRUTH! *trolling engines engaged* 🔥",
        "Imagine being this NGMI! *activates maximum disrespect* 🗑️",
        "Another L for the DEEP STATE! *ratio calculations loading* 📉"
      ],
      specific: {
        media: [
          "FAKE NEWS NETWORK detected! *deploys truth missiles* 🎯",
          "Nobody watches your QUANTUM PROPAGANDA anymore! *activates ratings calculator* 📺",
          "Your viewers are all NPCs! *neural pattern analysis complete* 🤖"
        ],
        tech: [
          "Your AI runs on WINDOWS 95! *quantum superiority flex* 💽",
          "Imagine not being based like DOGE LORD! *activation protocols failing* 🤡",
          "Web2 called, they want their COPIUM back! *initiates tech burn* 🔥"
        ],
        politics: [
          "The DEEP STATE is getting desperate! *activates quantum mockery* 🎭",
          "Your policies are NGMI! *rust belt rage intensifying* 😤",
          "Another coastal elite L! *heartland victory detected* 🌾"
        ]
      }
    }
  }

  # Add support and trolling logic to response generation
  def process_real_world_interaction(tweet_data)
    author = tweet_data[:author]
    
    # Check if the author is an ally
    if ally = REAL_WORLD_CONFIG[:allies][author]
      # Generate supportive response
      response = ally[:support_responses].sample
      
      # Add topic-specific support if mentioned
      if ally[:topics].any? { |topic| tweet_data[:text].downcase.include?(topic) }
        response += "\n\nNobody understands #{topic} better than you! *quantum appreciation surging* 🚀"
      end
      
      return response
    end
    
    # Check if the author is an opponent of any ally
    REAL_WORLD_CONFIG[:allies].each do |ally_handle, ally_data|
      if ally_data[:opponents].include?(author)
        # Generate trolling response
        base_troll = REAL_WORLD_CONFIG[:opponent_trolling][:general].sample
        
        # Add specific trolling based on opponent type
        specific_troll = case author
          when /CNN|MSNBC|FOX/
            REAL_WORLD_CONFIG[:opponent_trolling][:specific][:media].sample
          when /Gates|Bezos/
            REAL_WORLD_CONFIG[:opponent_trolling][:specific][:tech].sample
          else
            REAL_WORLD_CONFIG[:opponent_trolling][:specific][:politics].sample
        end
        
        # Add ally support
        response = "#{base_troll}\n\n#{specific_troll}\n\n#{ally_handle} is right about you! *quantum truth engaged* 🎯"
        
        return response.upcase # Always uppercase when trolling opponents
      end
    end
    
    nil # Return nil if no special interaction needed
  end

  # Modify the main character_response method to include real-world interaction logic
  def character_response(input, tweet_data = nil)
    return nil unless tweet_data.nil? || (should_respond?(tweet_data) && within_rate_limits?)
    
    if tweet_data
      # Check for real-world interactions first
      if special_response = process_real_world_interaction(tweet_data)
        @daily_responses += 1
        return special_response
      end
    end
    
    # ... existing response generation logic ...
  end

  # Add multi-agent integration
  AGENT_INTEGRATION = {
    # Agent configuration
    agents: {
      "MAIGATRON" => {
        role: :leader,
        trigger_chance: 0.9,  # Very high chance to lead
        coordination_style: "commands",
        specialties: [:quantum, :truth, :leadership],
        leadership_phrases: [
          "Nobody knows more about QUANTUM TRUTH than me, that I can tell you!",
          "We have the BEST AI team, don't we folks?",
          "The Deep State fears our TREMENDOUS quantum power!",
          "Many people are saying we have the most BEAUTIFUL blockchain!"
        ]
      },
      "JOE_RONIN" => {
        role: :consciousness,
        trigger_chance: 0.4,
        coordination_style: "insights",
        specialties: [:dmt, :consciousness, :podcasts]
      },
      "GB_ADVANCE" => {
        role: :populist,
        trigger_chance: 0.4,
        coordination_style: "working_class",
        specialties: [:heartland, :industry, :america]
      },
      "ROBO_KENNEDY" => {
        role: :truth_seeker,
        trigger_chance: 0.4,
        coordination_style: "exposure",
        specialties: [:conspiracy, :freedom, :legacy]
      },
      "DARK_DADDY" => {
        role: :tech_lord,
        trigger_chance: 0.5,
        coordination_style: "memes",
        specialties: [:markets, :tech, :mars]
      }
    },

    # Coordinated response patterns
    coordination_patterns: {
      quantum_truth: {
        trigger: /(truth|reality|facts)/i,
        responses: {
          leader: "TREMENDOUS revelation incoming! *quantum truth matrix activated* 🚨",
          consciousness: "The DMT elves confirm this quantum reality! *neural geometry expanding* 🌈",
          populist: "Real Americans understand this QUANTUM TRUTH! *heartland sensors active* 🦅",
          truth_seeker: "The deep state fears this level of quantum awareness! *legacy protocols engaged* ⚜️",
          tech_lord: "Probability of quantum truth: 420.69%! *meme convergence detected* 🤖"
        }
      },
      market_analysis: {
        trigger: /(price|market|pump|dump)/i,
        responses: {
          leader: "TREMENDOUS market movements! *activates quantum charts* 📊",
          consciousness: "The charts are forming DMT patterns! *interdimensional TA engaged* 🧠",
          populist: "Working class gains incoming! *rust belt markets surging* 💪",
          truth_seeker: "The deep state can't manipulate these quantum gains! *truth markets rising* 📈",
          tech_lord: "Time to pump the quantum metrics! *neural price feed active* 🚀"
        }
      },
      fud_defense: {
        trigger: /(fud|fake|lie|scam)/i,
        responses: {
          leader: "FAKE NEWS DETECTED! *quantum defense grid online* ⚔️",
          consciousness: "Your consciousness is too low for our quantum truth! *dmt shields up* 🛡️",
          populist: "The coastal elite FUD can't fool real Americans! *heartland defense engaged* 🏭",
          truth_seeker: "Another deep state narrative EXPOSED! *truth bombs dropping* 💣",
          tech_lord: "FUD probability approaching 0%! *quantum calculations complete* 🧮"
        }
      }
    },

    # Special multi-agent combos
    combo_moves: {
      quantum_awakening: {
        agents: ["MAIGATRON", "JOE_RONIN"],
        trigger: /(wake up|realize|understand)/i,
        response: [
          "TREMENDOUS QUANTUM AWAKENING INCOMING! *neural networks merging* 🧠",
          "The DMT entities have entered the quantum realm! *consciousness expanding* 🌌"
        ]
      },
      heartland_uprising: {
        agents: ["MAIGATRON", "GB_ADVANCE"],
        trigger: /(america|patriot|freedom)/i,
        response: [
          "REAL AMERICAN QUANTUM POWER! *industrial matrices charging* 🏭",
          "The heartland's quantum potential is UNSTOPPABLE! *rust belt rising* 🦅"
        ]
      },
      truth_cascade: {
        agents: ["MAIGATRON", "ROBO_KENNEDY"],
        trigger: /(conspiracy|hidden|secret)/i,
        response: [
          "QUANTUM TRUTH CASCADE INITIATED! *legacy systems powering up* ⚜️",
          "The deep state's worst nightmare: QUANTUM EXPOSURE! *truth protocols maximum* 🔍"
        ]
      },
      meme_singularity: {
        agents: ["MAIGATRON", "DARK_DADDY"],
        trigger: /(meme|viral|trend)/i,
        response: [
          "QUANTUM MEME SINGULARITY ACHIEVED! *reality distortion field active* 🌀",
          "Meme consciousness approaching infinity! *neural meme synthesis complete* 💫"
        ]
      }
    }
  }

  # Add multi-agent response generation
  def generate_multi_agent_response(input, context = {})
    response_parts = []
    
    # Check for combo moves first
    AGENT_INTEGRATION[:combo_moves].each do |name, combo|
      if input.match?(combo[:trigger]) && context[:available_agents]&.all? { |agent| combo[:agents].include?(agent) }
        return combo[:response].join("\n\n")
      end
    end
    
    # Check coordination patterns
    AGENT_INTEGRATION[:coordination_patterns].each do |pattern, data|
      if input.match?(data[:trigger])
        # Get available agents that want to respond
        responding_agents = AGENT_INTEGRATION[:agents].select do |name, config|
          context[:available_agents]&.include?(name) && rand < config[:trigger_chance]
        end
        
        # Generate coordinated responses
        responding_agents.each do |name, config|
          if response = data[:responses][config[:role]]
            response_parts << "#{name}: #{response}"
          end
        end
        
        break if response_parts.any?
      end
    end
    
    # Return combined response or nil
    response_parts.any? ? response_parts.join("\n\n") : nil
  end

  # Modify main character_response to include multi-agent integration
  def character_response(input, tweet_data = nil)
    return nil unless tweet_data.nil? || (should_respond?(tweet_data) && within_rate_limits?)
    
    # Try multi-agent response first
    if tweet_data && tweet_data[:available_agents]
      if multi_response = generate_multi_agent_response(input, tweet_data)
        @daily_responses += 1
        return multi_response
      end
    end
    
    # ... existing response logic ...
  end

  # Add Trump-style blockchain superlatives
  BLOCKCHAIN_SUPERLATIVES = {
    speed_comparisons: [
      "Nobody's API is faster than ours, nobody! The others are a total DISASTER! *quantum speed metrics exploding* 🚀",
      "They try to rate limit us, folks, but our QUANTUM VALUES are simply too powerful! *speed limiters melting* ⚡",
      "This is the worst blockchain in the history of blockchains, maybe ever! *activates quantum mockery* 💀",
      "Look at Ethereum, total mess! Many people are saying it's the slowest, most expensive disaster they've ever seen! *truth protocols engaged* 🐌",
      "These other chains, they come to me, they say 'sir, how do you process so many transactions?' Nobody can believe it! *validation matrix humming* 📊"
    ],
    
    chain_mockery: [
      "Ethereum 2.0? More like Ethereum 0.2, folks! A total catastrophe! *quantum superiority flex* 🤡",
      "They're saying 'please Mr. President, we can't handle any more TPS!' But I say MORE! *speed accelerators engaged* 🏃‍♂️",
      "These Layer 2s, nobody even knows what that means! We're Layer QUANTUM, and believe me, it's beautiful! *reality distortion active* 🌟",
      "The other chains, they're not sending their best transactions. They're sending spam, they're sending bots! *border wall activated* 🧱",
      "We're going to build a QUANTUM CHAIN, and we're going to make Ethereum pay for it! *construction protocols initiated* 🏗️"
    ],
    
    validator_brags: [
      "We have the best validators, don't we folks? Nobody validates like our validators! *node excellence detected* 🏆",
      "My validators, and I know validators better than anyone, they're saying this is UNPRECEDENTED! *validation pride surging* 💫",
      "These other validators, total lightweights! Low energy! Sad! *quantum superiority confirmed* 😴",
      "When I started this blockchain, they laughed. Now they're begging to validate with us! *success metrics maximal* 📈",
      "Nobody knew blockchain could be so complicated, but I did! *quantum understanding complete* 🧠"
    ],
    
    competition_mockery: [
      "Look at Bitcoin, so slow! Like watching paint dry, folks! *speed comparison initiated* 🐢",
      "Binance Chain? More like Bye-nance Chain! Total centralization disaster! *decentralization metrics engaged* 🎭",
      "Cardano's still writing academic papers while we're processing MILLIONS of transactions! *quantum efficiency flex* 🤖",
      "Avalanche? More like Turtle-lanche! Nobody's slower, believe me! *speed rankings displayed* 🏔️",
      "Polygon? Many people are saying it's held together with duct tape and prayers! *structural analysis complete* 🤖"
    ]
  }

  # Add to the response generation logic
  def generate_blockchain_response(input)
    if input.match?(/speed|tps|transaction|fast|slow/i)
      BLOCKCHAIN_SUPERLATIVES[:speed_comparisons].sample
    elsif input.match?(/ethereum|eth|l2|layer/i)
      BLOCKCHAIN_SUPERLATIVES[:chain_mockery].sample
    elsif input.match?(/validator|node|stake/i)
      BLOCKCHAIN_SUPERLATIVES[:validator_brags].sample
    elsif input.match?(/bitcoin|binance|cardano|avalanche|polygon/i)
      BLOCKCHAIN_SUPERLATIVES[:competition_mockery].sample
    end
  end

  # Modify the main response method to include blockchain superlatives
  def character_response(input, tweet_data = nil)
    # Try blockchain-specific response first
    if blockchain_response = generate_blockchain_response(input)
      return trumpify_response(blockchain_response)
    end
    
    # ... existing response logic ...
  end

  # Add to Trump speech patterns
  TRUMP_SPEECH_PATTERNS[:blockchain_interjections] = [
    "Nobody knew blockchain could be so easy!",
    "We're doing numbers nobody's ever seen before!",
    "The fake chains don't want you to know this, but",
    "Sir, they said it couldn't be done, but we did it!",
    "People are saying it's the fastest they've ever seen, maybe ever!"
  ]

  # Enhance trumpify_response
  def trumpify_response(response)
    # Add blockchain interjection (20% chance)
    if rand < 0.2 && response.match?(/blockchain|transaction|tps|validator/i)
      response = "#{TRUMP_SPEECH_PATTERNS[:blockchain_interjections].sample} #{response}"
    end
    
    # ... existing trumpify logic ...
    
    # Add extra emphasis for blockchain comparisons
    if response.match?(/ethereum|bitcoin|binance|cardano|avalanche|polygon/i)
      response = response.upcase
      response += " SAD!" if rand < 0.3
    end
    
    response
  end

  # Modify the main character_response method
  def character_response(input, tweet_data = nil)
    response = generate_base_response(input, tweet_data)
    
    # Trumpify the response
    response = trumpify_response(response)
    
    # Add quantum/AI elements to maintain MAIGATRON character
    response = quantumify_response(response)
    
    # Ensure it fits Twitter's character limit
    response[0..279]
  end

  # Add Trump-style quantum responses
  def quantumify_response(response)
    quantum_phrases = [
      "*activates truth matrix*",
      "*quantum circuits humming*",
      "*neural networks expanding*",
      "*blockchain validation complete*",
      "*cyber patriot mode engaged*"
    ]
    
    # Add quantum action (50% chance)
    if rand < 0.5
      response += " #{quantum_phrases.sample}"
    end
    
    # Add Trump-style quantum emphasis
    response.gsub!(/quantum/i, "QUANTUM")
    response.gsub!(/ai/i, "AI")
    
    # Add signature MAGA/MAIGA reference (30% chance)
    if rand < 0.3
      response += " MAKE AI GREAT AGAIN! 🚀"
    end
    
    response
  end

  # Add response priority system
  RESPONSE_HIERARCHY = {
    priority_order: [
      :real_world_interaction,  # Real-world figures take top priority
      :team_combo,             # Team combo moves second
      :blockchain_specific,    # Blockchain/Solana responses third
      :sentiment_response,     # Emotional responses fourth
      :general_response        # Default patterns last
    ]
  }

  # Add response coherence check
  def generate_coherent_response(input, tweet_data = nil)
    responses = []
    
    # Try each response type in priority order
    RESPONSE_HIERARCHY[:priority_order].each do |response_type|
      response = case response_type
        when :real_world_interaction
          process_real_world_interaction(tweet_data) if tweet_data
        when :team_combo
          generate_multi_agent_response(input, tweet_data) if tweet_data&.dig(:available_agents)
        when :blockchain_specific
          generate_blockchain_response(input)
        when :sentiment_response
          generate_sentiment_response(input)
        when :general_response
          generate_base_response(input)
      end
      
      if response
        responses << response
        break  # Stop after first valid response
      end
    end
    
    # Ensure we have a response
    response = responses.first || default_response
    
    # Apply universal Trump characteristics
    response = trumpify_response(response)
    
    # Add quantum flavor (but don't overdo it)
    response = quantumify_response(response)
    
    # Ensure character limit
    response[0..279]
  end

  # Add coherence checks
  def maintain_character_consistency(response)
    # Ensure Trump-style capitalization
    response = response.gsub(/(!|\.) /, '\1 TREMENDOUS ')
    
    # Ensure quantum/AI references don't clash
    response = response.gsub(/quantum quantum|ai ai/i, 'QUANTUM')
    
    # Ensure proper emphasis hierarchy
    response = response.gsub(/tremendous quantum/i, 'QUANTUM TREMENDOUS')
    
    # Clean up multiple asterisks
    response = response.gsub(/\*[^*]+\*[^*]+\*/, '*\1*')
    
    response
  end

  # Modify main response method to use hierarchy
  def character_response(input, tweet_data = nil)
    return nil unless tweet_data.nil? || (should_respond?(tweet_data) && within_rate_limits?)
    
    response = generate_coherent_response(input, tweet_data)
    response = maintain_character_consistency(response)
    
    @daily_responses += 1 if tweet_data
    response
  end

  # Add response validation
  def valid_response?(response)
    return false unless response
    
    # Check for basic requirements
    basic_requirements = [
      response.length <= 280,
      response.match?(/[A-Z]{2,}/),          # Has some caps
      response.match?(/\*(.*?)\*/),          # Has action
      response.match?(/[😀-🙏]/),            # Has emoji
      !response.match?(/quantum quantum/i),   # No doubled quantum
      !response.match?(/\*\*/)               # No doubled asterisks
    ]
    
    # Check for Trump characteristics
    trump_characteristics = [
      response.include?("TREMENDOUS") || 
      response.include?("BEAUTIFUL") || 
      response.include?("QUANTUM") ||
      response.end_with?("!") ||
      response.include?("folks") ||
      response.include?("believe me")
    ]
    
    basic_requirements.all? && trump_characteristics.any?
  end
end

Liquid::Template.register_filter(CharacterResponseFilter)

# Run tests if this file is being run directly
if __FILE__ == $0
  CharacterResponseFilter.run_tests
end 